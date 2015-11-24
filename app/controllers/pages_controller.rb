require 'json'

class PagesController < ApplicationController

  def initialize
    @sample_json =JSON.parse('{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}')
  end

  def home
    respond_to do |format|
      format.html
      format.json { render json: @sample_json }
    end
  end
  
end
