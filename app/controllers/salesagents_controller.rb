class AgentsController < ApplicationController
  use Rack::Flash

  get '/agents/new' do
    if logged_in?
      flash[:message] = "Agent Logged In. Please log out first before signing up."

      erb :'index'
      #redirect to("/leads")
    else
      erb :'agents/create_agent'
    end
  end


  post '/agents' do
    binding.pry
    if params[:name] == "" || params[:password] == ""
      flash[:message] = "Please try again."
      redirect to ("/agents/new")
    elsif (params[:region_name_1] == "" && params[:region_name_2].nil?) || (params[:region_name_1] != "" && !params[:region_name_2].nil?)
      flash[:message] = "Please try again."
      redirect to ("/agents/new")
    else
      if params[:region_name_1] == ""
        region_name = params[:region_name_2]
      else
        region_name = params[:region_name_1]
      end
      @user = Agent.create(name: params[:name], password: params[:password])
      @region = Region.find_or_create_by(name: region_name)
      @region.agents << @user
      @region.save
      @user.save
      session[:user_id] = @user.id
    end
    redirect to("/leads/new")
  end


  get '/login' do
    if logged_in?
      @user = Agent.find_by(id: session[:user_id])
      flash[:message] = "Agent Logged In. Please log out first before signing up."
      redirect to("/leads")
    end

    erb :'agents/login'
  end

  post '/login' do
    #binding.pry
    @user = Agent.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to("/leads")
    else
      flash[:message] = "Please try again."
      redirect to("/login")
    end
  end


  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to ("/")
  end


end
