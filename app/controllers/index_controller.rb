class IndexController < ApplicationController
  def index
    @base_app = "Acorn"
    respond_to do |format|
      format.js
      format.html
      format.json { render json: @home }
    end
  end
end
