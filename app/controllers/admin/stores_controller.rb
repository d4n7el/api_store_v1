class Admin::StoresController < ApplicationController
  before_action :authenticate_user
  before_action :set_store, only: [ :update, :edit ]
  before_action :is_admin?, only: [:update, :index, :create, :edit]

  def index 
    stores = Store.all.limit(20).offset(params[:offset] || 0)
    render json: stores, status: :ok
  end

  def create 
    store = Store.new(store_params)
    if store&.save
      render json: store, status: :ok
    else
      render json: store, status: :bad_request
    end
  end

  def update
    if @store&.update(store_params)
      render json: @store, status: :ok
    else
      render status: :bad_request
    end
  end

  def edit 
    render json: @store, status: :ok 
  end

  private

  def store_params
    params.permit(:name, :address, :description, :user_id, :status)
  end

  def set_store 
    @store = Store.find(params[:id])
  end

end
