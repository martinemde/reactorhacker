require 'haml'
require 'sinatra/base'
require File.dirname(__FILE__) + '/lib/term'

class Fallout3Hacker < Sinatra::Base
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
    session[:words] = nil
    haml :new
  end

  get '/words' do
    redirect '/solutions'
  end

  post '/words' do
    session[:term] = Term.new(params[:words])
    return redirect('/') if current_term.empty?
    redirect '/solutions'
  end

  get '/solutions' do
    return redirect('/') if current_term.empty?
    haml :solutions
  end

  helpers do
    def current_term
      session[:term] || []
    end
  end
end
