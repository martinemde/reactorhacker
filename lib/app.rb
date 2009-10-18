require 'haml'
require 'sinatra/base'
require 'term'

class App < Sinatra::Base
  helpers Haml::Helpers

  set :app_file, __FILE__
  enable :static, :sessions, :logging
  set :haml, {:attr_wrapper => '"'}

  not_found do
    haml :not_found
  end

  error do
    haml :error
  end

  get '/' do
    session[:term] = nil
    haml :new
  end

  post '/words' do
    session[:term] = Term.new(params[:words])
    if current_term.empty?
      redirect '/'
    else
      redirect '/suggestion'
    end
  end

  get '/words' do
    redirect '/suggestion'
  end

  get '/suggestion' do
    if current_term.empty?
      redirect '/'
    else
      params.each do |word,correct|
        @term = current_term.pick(word, correct)
      end
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
  end
end