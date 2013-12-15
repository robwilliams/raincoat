module WorldWeather
  class Response < Struct.new(:response)
    include Enumerable

    def each(&block)
      weather_array.each do |forecast|
        block.call(forecast)
      end
    end

    def success?
      response.fetch("data", {}).has_key?("current_condition")
    end

    def temp_c
      current_condition["temp_C"]
    end

    def temp_f
      current_condition["temp_F"]
    end

    def description
      current_condition["weatherDesc"].first["value"]
    end

    private
    def data
      response.fetch("data")
    end

    def current_condition
      data.fetch("current_condition").first
    end

    def weather_array
      data.fetch("weather").map{|e| Forecast.new(e) }
    end

    class Forecast < Struct.new(:data)
      def icon_url
        data["weatherIconUrl"].first["value"]
      end

      def date
        Date.parse(data["date"])
      end

      def temp_min_c
        data["tempMinC"]
      end

      def temp_max_c
        data["tempMaxC"]
      end
    end
  end
end
