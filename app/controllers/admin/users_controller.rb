class Admin::UsersController < ApplicationController
  before_action :authenticate_user,except: [:create]
  before_action :only_admin, only: [:index, :update, :destroy]

  def index
    users = User.all
    render json: {users: users, current_user: current_user}
  end

  def update
    user = User.find(params[:id])
    authorize user
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
    authorize user
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
    params.permit(:username, :email, :password, :password_confirmation, :admin, :owner, :customer, :seller )
  end

  def only_admin
    authorize current_user
  end
end
