module WorldWeather
  class Weather
    PATH = 'weather.ashx'

    def initialize(client)
      @client = client
    end

    def get(location)
      ResponseDecorator.new(client.get(PATH, q: location).data)
    end

    private
    attr_reader :client

    class ResponseDecorator < Struct.new(:data)

      def valid?
        !data.respond_to?("error")
      end

      def current_condition
        data.current_condition.first
      end

      def method_missing(*args)
        data.public_send(*args)
      end
    end
  end
end
