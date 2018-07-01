class LeadsController < ApplicationController

  get '/leads' do

    erb :'leads/leads'
  end

  get '/leads/new' do
    binding.pry
    @user = Agent.find_by(name: session[:user_id])

    erb :'leads/new'
  end



end
