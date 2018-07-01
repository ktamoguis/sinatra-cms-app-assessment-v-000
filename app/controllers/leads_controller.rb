class LeadsController < ApplicationController

  get '/leads' do

    erb :'leads/leads'
  end

  get '/leads/new' do
    binding.pry
    @user = Agent.find_by(id: session[:user_id])

    erb :'leads/create_lead'
  end

  post '/leads' do
    binding.pry
    @lead = Lead.create(name: params[:name])
    @lead.status = "Go"
    @lead.save

    erb :'leads/leads'

  end




end
