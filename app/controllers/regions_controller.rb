class RegionsController < ApplicationController

  get '/regions' do
    if !logged_in?
      redirect to ("/")
    else
      erb :'/regions/regions'
    end
  end

  get '/regions/:region_id' do
    if !logged_in?
      redirect to ("/")
    else
      @region = Region.find_by(id: params[:region_id])
      if @region == current_user.region

        erb :'/regions/show_region'
      else
        redirect to("/regions")
      end
    end
  end

  get '/regions/new' do
    
  end

end
