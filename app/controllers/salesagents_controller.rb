class AgentsController < ApplicationController

  get '/agents/new' do
    if logged_in?
      redirect to("/leads")
    else
      erb :'agents/create_agent'
    end
  end

  post '/agents' do
    if params[:username] == "" || params[:password] == ""
      redirect to("/signup")
    else
      @user = Agent.create(params)
      @user.save
      session[:user_id] = @user.id
    end

    redirect to("/leads")

  end


end
