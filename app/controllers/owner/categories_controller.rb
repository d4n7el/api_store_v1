class Owner::CategoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_category, only: [:update, :edit, :destroy]
  before_action :is_owner?, only: [:update, :index, :destroy , :create]
  before_action :validate_permit_update_category, only: [:update, :edit, :destroy]

  def index
    categories = params[:store_id] ? Category.where(store_id: params[:store_id]) : User.find(current_user.id).categories
    render json: {categories: categories, current:  current_user}
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :ok
    else
      render status: :bad_request
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render status: :bad_request
    end
  end

  def edit
    render json:  @category
  end

  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.permit(:name, :description, :store_id)
  end

  def validate_permit_update_category
    permit_update_category?(@category) unless current_user.admin?
  end

end
