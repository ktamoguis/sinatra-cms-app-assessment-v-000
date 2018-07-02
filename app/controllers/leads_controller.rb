class LeadsController < ApplicationController


  get '/leads/new' do
    binding.pry
    if !logged_in?
      redirect to ("/")
    else
      @user = Agent.find_by(id: session[:user_id])

      erb :'leads/create_leads'
    end
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

  get '/leads' do
    if !logged_in?
      redirect to ("/")
    else
      @user = Agent.find_by(id: session[:user_id])

      erb :'leads/leads'
    end
  end

  get '/leads/:id' do
    if !logged_in?
      redirect to ("/")
    else
      @lead = Lead.find_by(id: params[:id])

      erb :'leads/show_lead'
    end
  end

  get '/leads/:id/update' do
    if !logged_in?
      redirect to ("/")
    else
      @lead = Lead.find_by(id: params[:id])

      erb :'leads/edit_lead'
    end


  end

  patch '/leads/:lead_id' do
    @leads = Lead.find_by(id: params[:lead_id])
    binding.pry
    if @leads.nil?
      redirect to("/leads")
    else
    end
  end

  delete '/leads/:id/delete' do
    @lead = Lead.find_by(id: params[:id])
    binding.pry
    if session[:user_id] == current_user.id
      #binding.pry
      @lead.delete
    end
    redirect to("/leads")
  end


  delete '/leads/delete' do #delete action
    binding.pry
    @lead = Lead.find_by(id: params[:lead_id])
    binding.pry
    if session[:user_id] == current_user.id
      #binding.pry
      @lead.delete
    end
    redirect to("/leads")
  end




end
