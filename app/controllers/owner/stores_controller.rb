class Owner::StoresController < ApplicationController
  before_action :authenticate_user,except: [ :create ]
  before_action :set_store, only: [ :update, :edit ]
  before_action :is_owner?, only: [:update, :index, :edit]
  before_action :validate_the_record, only: [:update, :edit]

  def index 
    stores = Store.where(user_id: current_user)
    render json: stores, status: :ok
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
    params.permit(:name, :address, :description, :status)
  end

  def set_store 
    @store = Store.find(params[:id])
  end

  def validate_the_record
    owns_the_record(@store)
  end

end
