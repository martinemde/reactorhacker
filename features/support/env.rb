app_file = File.join(File.dirname(__FILE__), *%w[.. .. lib reactorhacker.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
#Sinatra::Application.app_file = app_file

require 'spec/expectations'
require 'rack/test'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  def app
    @app = Rack::Builder.new do
      run ReactorHacker::App
    end
  end
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body, :response

  #def app
  #  ReactorHacker::App
  #end
end

World{MyWorld.new}
