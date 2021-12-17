class Owner::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :set_product, only: [ :edit, :update, :edit ]
  before_action :is_owner?, only: [ :index, :update ]
  before_action :permit_create_product?, only:[ :create, :edit, :update ]

  def index
    categories_ids = User.find(current_user.id).categories.ids
    products = Product.where(category_id: categories_ids )
    render json: {products: products , user: current_user}, status: :ok
  end

  def create 
    product = Product.new(product_params)
    if product.save
      render json: {product: product , user: current_user}, status: :ok
    else
      render status: :bad_request
    end
  end

  def edit 
    render json: {product: @product, user: current_user }, status: :ok
  end

  def update 
    if @product.update(product_params)
      render json: {product: @product , user: current_user}, status: :ok
    else
      render status: :bad_request
    end
  end

  private 

  def product_params
    params.permit(:name, :description, :quantity_available, :discount , :price, :status, :category_id)
  end

  def set_product 
    @product = User.find(current_user.id).categories.find(params[:category_id]).products.find(current_user.id) if current_user.owner?
    @product = Category.find(params[:category_id]).products.find(current_user.id) if current_user.admin?
  end

end
