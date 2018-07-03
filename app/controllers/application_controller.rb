require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      Agent.find(session[:user_id])
    end

    def blank_name_or_password?
      params[:name] == "" || params[:password] == ""
    end

    def no_region_name?
      params[:region_name_1] == "" && params[:region_name_2].nil?
    end

    def double_region_name?
       params[:region_name_1] != "" && !params[:region_name_2].nil?
    end

    def log_in_or_sign_up
      flash[:message] = "Please sign up or log-in first."
      redirect to ("/")
    end

    def already_logged_in
      flash[:message] = "Agent already logged in."
      redirect to('/')
    end


  end
end
