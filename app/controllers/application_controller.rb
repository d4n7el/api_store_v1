class ApplicationController < ActionController::API
  include Knock::Authenticable

  def is_admin?
    render status: :unauthorized and return unless current_user.admin?
  end

  def is_owner?
    render status: :unauthorized and return unless current_user.owner? || current_user.admin?
  end

  def owns_the_record (record)
    render status: :unauthorized and return unless current_user.id === record.user_id 
  end

  def permit_update_category? (record)
    validation = current_user.owner? || current_user.admin? and current_user.store_id === record.store_id  
    render status: :unauthorized and return unless validation
  end

  def is_my_store?
    render status: :unauthorized and return unless current_user.id === @store.user_id || current_user.admin?
  end


  def permit_create_product?
    validation = !current_user.admin? || !current_user.owner?
    render status: :unauthorized and return unless validation
  end

  def permit_update_product_category?
    render status: :unauthorized and return unless @my_categories.include?(params[:product][:category_id] ? params[:product][:category_id].to_i : params[:category_id].to_i )
  end

  def permit_update_product_category_admin?
    render status: :unauthorized and return unless @categories_available.include?(params[:category_id].to_i)
  end

end
