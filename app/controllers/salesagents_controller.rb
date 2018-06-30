class AgentsController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to("/leads")
    else
      erb :'agents/create_agent'
    end
  end


end
