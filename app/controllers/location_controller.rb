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
      if config.cache_store.exist?(@location_id)
        @photos = config.cache_store.read(@location_id)
        puts("hit")
      else
        @photos = JSON.parse(redis.get("location_#{@location_id}") || '[]')
        config.cache_store.write(@location_id, @photos)
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end
end
