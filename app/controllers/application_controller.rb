class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    render json: {error: 'You are not authorized to perform this action.', status: :unauthorized}
    head(:unauthorized)
  end
end
