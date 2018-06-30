class AgentsController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to("/leads")
    else
      erb :'agents/create_agent'
    end
  end

  post '/agents/new' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect to("/signup")
  else
    @user = User.create(params)
    @user.save
    session[:user_id] = @user.id
  end

  redirect to("/leads")

  end


end
