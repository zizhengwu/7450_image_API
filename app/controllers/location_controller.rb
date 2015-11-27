require 'json'
require 'redis'

class LocationController < ApplicationController

  def show
    redis = Redis.new

    @location_id = params['location_id']
    if params.has_key?('unix_time')
      @unix_time = params['unix_time']
      @photos = JSON.parse(redis.get("location_#{@location_id}_#{@unix_time}") || '[]')
    else
      @photos = JSON.parse(redis.get("location_#{@location_id}") || '[]')
    end

    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end
end
