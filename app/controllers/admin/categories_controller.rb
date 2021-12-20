class Admin::CategoriesController < Owner::CategoriesController

  def index 
    categories = Category
                  .where(store_id: params[:store_id])
                  .limit(20)
                  .offset(params[:offset] || 0)

    render json: {categories: categories, current:  current_user}
  end

end