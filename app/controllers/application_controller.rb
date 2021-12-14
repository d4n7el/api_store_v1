class ApplicationController < ActionController::API
  include Knock::Authenticable

  def is_admin?
    render status: :unauthorized and return unless current_user.admin?
  end

  def is_owner?
    render status: :unauthorized and return unless current_user.owner?
  end

  def owns_the_record? (record)
    render status: :unauthorized and return unless current_user.id === record.user_id
  end

end
