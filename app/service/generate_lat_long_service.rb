class GenerateLatLongService
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(restaurant:)
    @restaurant = restaurant
    @address = restaurant.address
  end

  def call
    get_place 
    return errors if errors.presence

    if save_lat_long(lat: get_place.latitude.to_f, long: get_place.longitude.to_f)
      return @restaurant
    else
      errors
    end
  end

  def save_lat_long(lat:, long:)
    ActiveRecord::Base.transaction do
      @restaurant.update(lat:, long: )
    end
  end

  def get_place
    begin
      places = Google::Maps.places(@address)
    rescue Google::Maps::ZeroResultsException => e
      return errors.add(:base, "Não encontrado endereco")
    end
    
    place_id = places.first.place_id
    Google::Maps.place(place_id)
  end
end