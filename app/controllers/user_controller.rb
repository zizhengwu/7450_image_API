require 'json'
require 'redis'

class UserController < ApplicationController
  def show
    @user_id = params['user_id']

    redis = Redis.new
    @photos = JSON.parse(redis.get("user_#{@user_id}") || '[]')
    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end
end
