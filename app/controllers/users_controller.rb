class UsersController < ApplicationController
  before_action :authenticate_user,except: [:create]

  def update
    user = User.find(current_user.id)
    if user&.update(user_params)
      render json: user
    else
      render status: :unprocessable_entity
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def edit 
    user = User.find(current_user.id)
    if user
      render json: user, status: :ok
    else
      render status: :not_found
    end
  end

  private 

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
