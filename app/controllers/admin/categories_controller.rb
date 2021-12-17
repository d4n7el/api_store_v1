class Admin::CategoriesController < Owner::CategoriesController

  def index 
    categories = Category.all.limit(20).offset(params[:offset] || 0)
    render json: {categories: categories, current:  current_user}
  end

end