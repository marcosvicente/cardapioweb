class GetOpenRestaurantService
  prepend SimpleCommand
  include ActiveModel::Validations

  WEEK = ['segunda', 'terça', 'quarta', 'quinta', 'sexta']
  ENDWEEK = ['sábado', 'domingo']

  # segunda à sexta das 10h às 17h e de sábado à domingo das 12h às 20h
  def initialize(restaurant_id:, times_open: , day_of_week:)
    @restaurant_id = restaurant_id
    @times_open = times_open.to_i
    @day_of_week = day_of_week
  end

  def call
    open_hour, close_hour = factory_days

    return errors if errors.present?

    if open_hour.to_i <= @times_open && @times_open <= close_hour.to_i 
      return result = "Aberto"
    else
      return result = "Fechado"
    end
  end

  def factory_days
    time = get_times
    
    if WEEK.include?(@day_of_week)
      get_week_open_hours(time[0])
    elsif ENDWEEK.include?(@day_of_week)
      get_end_of_week_open_hours(time[1])
    else
      errors.add(:day_of_week, "parametro não e valido")
    end
  end

  def get_times
    restaurant = Restaurant.find(@restaurant_id)
    time = restaurant.opening_hours.split("sábado")
  end

  def get_week_open_hours(time)
    open_hour, close_hour = sanitazite_time(time)
  end

  def get_end_of_week_open_hours(time)
    open_hour, close_hour = sanitazite_time(time)
  end

  def sanitazite_time(time)
    time.scan(/\d+/)
  end
end