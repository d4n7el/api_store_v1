class Admin::UsersController < ApplicationController
  before_action :authenticate_user,except: [:create]
  before_action :is_admin?, only: [:update, :index, :create, :edit, :destroy]

  def index
    users = User.all
    render json: {users: users, current_user: current_user}
  end

  def update
    user = User.find(params[:id])
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
    user = User.find(params[:id])
    if user
      render json: user, status: :ok
    else
      render status: :not_found
    end
  end

  def destroy
    User.find(params[:id]).destroy
  end

  private 

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :role, :store_id )
  end
end
