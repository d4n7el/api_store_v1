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
    validation = current_user.store_id === record.store_id and current_user.owner?
    render status: :unauthorized and return unless validation
  end

end
