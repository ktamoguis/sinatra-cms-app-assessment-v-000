class LeadsController < ApplicationController
  use Rack::Flash

  get '/leads/new' do
    #binding.pry
    if !logged_in?
      log_in_or_sign_up
    else
      @user = Agent.find_by(id: session[:user_id])
      flash[:message] = ""
      erb :'leads/create_leads'
    end
  end

  post '/leads' do
    if params[:name] == ""
      flash[:message] = "Please try again"
      erb :'leads/create_leads'
    else
      @lead = Lead.create(name: params[:name])
      @lead.status = "Go"
      @lead.agent = Agent.find_by(id: session[:user_id])
      @lead.save
      flash[:message] = ""
      erb :'leads/leads'
    end
  end

  get '/leads' do
    if !logged_in?
      log_in_or_sign_up
    else
      @user = Agent.find_by(id: session[:user_id])

      erb :'leads/leads'
    end
  end

  get '/leads/show' do
    if !logged_in?
      log_in_or_sign_up
    elsif current_user.leads.find_by(id: params[:lead_id]).nil?
      flash[:message] = "Lead ID does not exit/belong to agent. Please try again."
      redirect to("/leads/leads")
    else
      @lead = current_user.leads.find_by(id: params[:lead_id])
      erb :'leads/show_lead'
    end
  end


  get '/leads/:lead_id' do
    if !logged_in?
      log_in_or_sign_up
    elsif current_user.leads.find_by(id: params[:lead_id]).nil?
      flash[:message] = "Lead ID does not exit/belong to agent. Please try again."
      erb :"/leads/leads"
    else
      @lead = current_user.leads.find_by(id: params[:lead_id])
      erb :'leads/show_lead'
    end
  end

  get '/leads/:lead_id/update' do
    if !logged_in?
      log_in_or_sign_up
    elsif current_user.leads.find_by(id: params[:lead_id]).nil?
      flash[:message] = "Please try again."
      redirect to("/leads/leads")
    else
      @lead = current_user.leads.find_by(id: params[:lead_id])
      erb :'leads/edit_lead'
    end
  end

  patch '/leads/:lead_id' do
    @lead = Lead.find_by(id: params[:lead_id])
    if @lead.nil?
      redirect to("/leads/#{params[:lead_id]}/update")
    else
      if params[:name] == ""
        flash[:message] = "Please try again."
        redirect to("/leads/#{params[:lead_id]}/update")
      else
        @lead.update(name: params[:name])
        @lead.update(status: params[:status])
        @lead.save
        @user = Agent.find_by(id: session[:user_id])
        erb :'leads/leads'
      end
    end
  end

  delete '/leads/:id/delete' do
    if session[:user_id] == current_user.id
      Lead.find_by(id: params[:id]).delete
    end
    redirect to("/leads")
  end


  delete '/leads/delete' do #delete action
    if session[:user_id] == current_user.id
      Lead.find_by(id: params[:lead_id]).delete
    end
    redirect to("/leads")
  end


end
