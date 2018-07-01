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

    if params[:name] == "" || params[:password] == ""
      if (params[:region_name_1] == "" && params[:region_name_2] == "") || (!params[:region_name_1] == "" && !params[:region_name_2] == "")
        redirect to ("/agents/new")
      end
    else
      binding.pry
      if params[:region_name_1] == ""
        region_name = params[:region_name_1]
      else
        region_name = params[:region_name_2]
      end
      @user = Agent.create(name: params[:name], password: params[:password])
      @region = Region.create(name: region_name)
      @region.agents << @user
      @user.save
      session[:user_id] = @user.id
      end
    end
    binding.pry
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
      binding.pry
      session.clear
      Region.all.clear
    end
    redirect to ("/")
  end


end
