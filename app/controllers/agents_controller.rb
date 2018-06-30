class AgentsController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to("/leads")
    else
      erb :'agents/create_agent'
    end
  end

  get '/login' do
    if logged_in?
      redirect to("/leads")
    end

    erb :'agents/login'
  end

end
