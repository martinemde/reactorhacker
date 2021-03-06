require 'haml'
require 'sinatra/base'

module ReactorHacker
  class App < Sinatra::Base
    helpers Haml::Helpers

    set :app_file, __FILE__
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    enable :static, :sessions, :logging
    set :haml, {:attr_wrapper => '"'}

    not_found do
      haml :not_found
    end

    error do
      haml :error
    end

    get '/' do
      haml :new
    end

    post '/new' do
      session[:term] = nil
      redirect '/'
    end

    post '/' do
      session[:term] = Term.new(params[:words])
      if current_term.empty?
        redirect '/'
      else
        redirect '/suggestion'
      end
    end

    get '/suggestion' do
      if current_term.empty?
        redirect '/'
      else
        @term = current_term.after_picking(params)
        haml :suggestion
      end
    end

    post '/pick' do
      if current_term.empty?
        redirect '/'
      else
        params.each do |word,correct|
          @term = current_term.pick(word, correct)
        end
        redirect '/suggestion'
      end
    end

    helpers do
      def current_term
        @term ||= session[:term] || Term.new([])
      end

      def suggestion
        @suggestion ||= current_term && current_term.suggestion
      end
    end
  end
end
