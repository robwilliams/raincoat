module WorldWeather
  class Weather
    PATH = 'weather.ashx'

    def initialize
      @client = WorldWeather::Client.new
    end

    def get(location)
      Response.new(client.get(PATH, q: location, num_of_days: 5))
    end

    private
    attr_reader :client
  end
end
