class LeadsController < ApplicationController
  use Rack::Flash

  get '/leads/new' do
    if !logged_in?
      flash[:message] = "Please sign up or log-in first."
      redirect to ("/")
    else
      @user = Agent.find_by(id: session[:user_id])
      flash[:message] = ""
      erb :'leads/create_leads'
    end
  end

  post '/leads' do
    @user = Agent.find_by(id: session[:user_id])
    if params[:name] == ""
      flash[:message] = "Please try again"
      erb :'leads/create_leads'
    else
      @lead = Lead.create(name: params[:name])
      @lead.status = "Go"
      @lead.agent = @user
      @lead.save
      flash[:message] = ""
      erb :'leads/leads'
    end
  end

  get '/leads' do
    if !logged_in?
      flash[:message] = "Please sign up or log-in first."
      redirect to ("/")
    else
      @user = Agent.find_by(id: session[:user_id])

      erb :'leads/leads'
    end
  end

  get '/leads/show' do
    if !logged_in?
      flash[:message] = "Please sign up or log-in first."
      redirect to ("/")
    else
      @lead = current_user.leads.find_by(id: params[:lead_id])
      if @lead.nil?
        flash[:message] = "Lead ID does not exit/belong to agent. Please try again."
        redirect to("/leads/leads")
      else

        erb :'leads/show_lead'
      end
    end


  end

  get '/leads/:lead_id' do
    #binding.pry
    if !logged_in?
      flash[:message] = "Please sign up or log-in first."
      redirect to ("/")
    else
      @lead = current_user.leads.find_by(id: params[:lead_id])
      if @lead.nil?
        @user = current_user
        flash[:message] = "Lead ID does not exit/belong to agent. Please try again."
        erb :"/leads/leads"
      else
        erb :'leads/show_lead'
      end
    end
  end

  get '/leads/:lead_id/update' do
    if !logged_in?
      flash[:message] = "Please sign up or log-in first."
      redirect to ("/")
    else
      @lead = current_user.leads.find_by(id: params[:lead_id])
      if @lead.nil?
        flash[:message] = "Please try again."
        redirect to("/leads/leads")
      else
        erb :'leads/edit_lead'
      end
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
    @lead = Lead.find_by(id: params[:id])
    if session[:user_id] == current_user.id
      @lead.delete
    end
    redirect to("/leads")
  end


  delete '/leads/delete' do #delete action
    #binding.pry
    @lead = Lead.find_by(id: params[:lead_id])
    #binding.pry
    if session[:user_id] == current_user.id
      #binding.pry
      @lead.delete
    end
    redirect to("/leads")
  end




end
