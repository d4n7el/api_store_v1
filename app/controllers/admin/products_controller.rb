class Admin::ProductsController < Owner::ProductsController
  before_action :set_category, only:[ :update ]
  before_action :validate_update_product_category?, only:[ :update ]

  def index
    products = Product.all
    render json: products
  end

  def set_product 
    @product = Product.find(params[:id]) if current_user.admin?
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def validate_update_product_category?
    @categories_available = Category.where(store_id: @category.store_id ).pluck(:id)
    permit_update_product_category_admin?
  end
end
