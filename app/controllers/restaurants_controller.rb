class RestaurantsController < ApplicationController
  # before_action :authorize_request

  before_action :set_restaurant, only: %i[ show update destroy ]
  # before_action :only_onwer_resource

  # GET /restaurants
  def index
    @restaurants = Restaurant.order(:created_at).page(paginate_params[:page]).per(paginate_params[:per_page])

    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    render json: @restaurant
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: @restaurant, status: :created, location: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.permit(
        :name,
        :address,
        :lat,
        :long,
        :logo,
        :opening_hours,
        :owner_id)
    end

    def paginate_params
      params.permit(
        :page, :per_page
      )
    end
end
