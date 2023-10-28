class AdministrationsController < ApplicationController
  def restaurants_owner
    owner = Owner.includes(:restaurant).find(params[:id])
    
    render json: { owner: owner, restaurant: owner.restaurant}, status: :ok
  end

  def change_restaurant_to_owner
    if params[:restaurant_id].nil? || params[:owner_id].nil?
      return render json: { error: 'Parâmetros obrigatórios não estão presentes!' },
                status: :unprocessable_entity
    end

    restaurant = Restaurant.find(params[:restaurant_id]) 
    if restaurant.update(owner_id: params[:owner_id].to_i)
      render json: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  def get_opened_restaurant
    @service = GetOpenRestaurantService.new(
      restaurant_id: params[:restaurant_id],
      times_open: params[:times_open],
      day_of_week: params[:day_of_week]
    ).call

    if @service.success?
      render json: @service.result, status: :ok
    else
      render json: @service.errors.full_messages, status: :unprocessable_entity
    end
  end
end
