class Location
  include ActiveModel::Model
  attr_accessor :name

  validates :name, presence: true

  def weather
    Rails.cache.fetch("weather_for_#{name}") {
      WorldWeather::Weather.new.get(name)
    }
  end
end
