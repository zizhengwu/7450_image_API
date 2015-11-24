require 'json'

class LocationController < ApplicationController

  def show
    @location_id = params['location_id']
    @unix_time = params['unix_time']
    @photos = Array.new
    if Rails.application.config.location_dict.has_key?(@location_id)
    Rails.application.config.location_dict[@location_id].each {
      |photo|
      if photo['created_time'] == @unix_time
        @photos << photo
      end
    }
    end
    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end
end
