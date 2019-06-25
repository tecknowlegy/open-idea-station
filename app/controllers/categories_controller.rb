class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  def index
    @categories = Category.all

    render json: { data: @categories }
  end

  def show; end

  def update; end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(category).permit(:name, :description)
  end
end
