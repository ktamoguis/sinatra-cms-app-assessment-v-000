class AgentsController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to("/leads")
    else
      erb :'agents/new'
    end
  end

end
