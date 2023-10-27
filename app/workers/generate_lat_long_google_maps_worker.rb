class GenerateLatLongGoogleMapsWorker
  include Sidekiq::Worker

  def perform(restaurant_id)
    restaurant = Restaurant.find(restaurant_id)
    GenerateLatLongService.new(restaurant: ).call
  end
end