class AgentsController < ApplicationController

  get '/agents/new' do
    if logged_in?
      redirect to("/leads")
    else
      erb :'agents/create_agent'
    end
  end

  post '/agents' do
    binding.pry
    if params[:name] == "" || params[:password] == "" || params[:region_name] == ""
      redirect to("/signup")
    else
      @user = Agent.create(params)
      @region = Region.create(name: params[:region_name])
      @user.regions << @region
      @user.save
      session[:user_id] = @user.id
    end

    redirect to("/leads/new")
  end

  get '/login' do
    #binding.pry
    if logged_in?
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
