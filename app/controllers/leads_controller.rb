class LeadsController < ApplicationController

  get '/leads' do

    erb :'leads/leads'
  end

  get '/leads/new' do
    binding.pry
    @user = Agent.find_by(id: session[:user_id])

    erb :'leads/create_leads'
  end

  post '/leads' do
    binding.pry
    @user = Agent.find_by(id: session[:user_id])
    @lead = Lead.create(name: params[:name])
    @lead.status = "Go"
    @lead.agent = @user
    @lead.save

    binding.pry

    erb :'leads/leads'

  end




end
