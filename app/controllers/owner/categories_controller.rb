class Owner::CategoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_category, only: [:update, :edit ]
  before_action :set_store, only: [ :update, :edit, :create]
  before_action :is_owner?, only: [ :update, :index, :create]
  before_action :validate_permit_update_category, only: [ :update, :edit ]
  before_action :is_my_store?, only: [ :update, :create, :created, :edit]

  def index
    categories = params[:store_id] ? Category.where(store_id: params[:store_id]) : User.find(current_user.id).categories
    render json: {categories: categories, current:  current_user}
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: {category: category, user: current_user}, status: :ok
    else
      render status: :bad_request
    end
  end

  def update
    if @category.update(category_params)
      render json: {category: @category, user: current_user}, status: :ok
    else
      render status: :bad_request
    end
  end

  def edit
    render json:  { category: @category, user: current_user }
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end 

  def set_store
    @store = Store.find(@category&.store_id ? @category.store_id : params[:category][:store_id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :store_id)
  end

  def validate_permit_update_category
    permit_update_category?(@category)
  end

end
