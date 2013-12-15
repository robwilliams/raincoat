class Location
  include ActiveModel::Model
  attr_accessor :name

  validates :name, presence: true

  def weather
    @weather ||= WorldWeather::Weather.new.get(name)
  end
end
