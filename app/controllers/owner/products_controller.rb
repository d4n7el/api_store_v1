class Owner::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :set_product, only: [ :edit, :update, :edit ]
  before_action :is_owner?, only: [ :index, :update ]
  before_action :permit_create_product?, only:[ :create, :edit, :update ]
  before_action :validate_update_product_category?, only:[ :update, :create ]

  def index
    categories_ids = User.find(current_user.id).categories.pluck(:id)
    products = Product.where(category_id: categories_ids )
    render json: {products: products , user: current_user}, status: :ok
  end

  def create
    params[:product][:category_id] = params[:category_id]
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
      render json: {product: @product }, status: :ok
    else
      render status: :bad_request
    end
  end

  private 

  def product_params
    params.require(:product).permit(:name, :description, :quantity_available, :discount , :price, :status, :category_id)
  end

  def set_product_owner
    product = Product.find(params[:id]) 
    user_categories = current_user.categories.pluck(:id)

    @product = product if user_categories.include?(product.id) 
    render status: :not_found and return unless user_categories.include?(product.id) 
  end

  def set_product 
    set_product_owner if current_user.owner?
  end

  def validate_update_product_category?
    @my_categories = current_user.categories.pluck(:id) if current_user.owner?
    permit_update_product_category? if current_user.owner?
  end

end
