class RegionsController < ApplicationController
  use Rack::Flash

  get '/regions' do
    if !logged_in?
      log_in_or_sign_up
    else
      erb :'/regions/regions'
    end
  end

  get '/regions/:region_id' do
    if !logged_in?
      log_in_or_sign_up
    else
      @region = Region.find_by(id: params[:region_id])
      if @region == current_user.region

        erb :'/regions/show_region'
      else
        flash[:message] = "Agent does not belong to that region. Please try again."
        redirect to("/regions")
      end
    end
  end

end
