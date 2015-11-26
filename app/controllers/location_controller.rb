require 'json'
require 'redis'

class LocationController < ApplicationController

  def show
    @location_id = params['location_id']
    @unix_time = params['unix_time']

    redis = Redis.new
    @photos = JSON.parse(redis.get("location_#{@location_id}_#{@unix_time}") || '[]')
    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end
end
