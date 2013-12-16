class Location
  include ActiveModel::Model
  attr_accessor :name

  validates :name, presence: true

  delegate :temp_c, 
           :temp_f, 
           :description, to: :weather, prefix: true

  def weather
    Rails.cache.fetch("weather_for_#{name}", expires_in: 4.hours) {
      WorldWeather::Weather.new.get(name)
    }
  end
end
