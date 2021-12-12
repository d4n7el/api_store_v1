class UsersController < ApplicationController
  before_action :authenticate_user,except: [:create]
  #after_action :verify_authorized, except: :create

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    authorize current_user
    render json: {users: users, current_user: current_user}
  end

  private 
  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
   end
end
