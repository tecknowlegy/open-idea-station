class IndexController < ApplicationController
  skip_before_action :authorize, only: :index
  def index
    @base_app = "Acorn"
    respond_to do |format|
      format.js
      format.html
      format.json { render json: @home }
    end
  end
end
