module WorldWeather

  ENDPOINT="http://api.worldweatheronline.com/free/v1/"

  class Client
    def initialize(options={})
      @endpoint = WorldWeather::ENDPOINT
      @api_key  = options.fetch(:api_key, ENV['WORLD_WEATHER_API_KEY'])
    end

    attr_reader :endpoint, :api_key

    def get(path, params={})
      params.merge!(key: api_key, format: 'JSON')
      rate_limit do
        connection.get(path, params).body
      end
    rescue Faraday::Error::ParsingError => e
      raise ApiError, e.message
    end

    private
    def connection
      Faraday.new(url: endpoint) do |faraday|
        #faraday.response :logger                  # log requests to STDOUT
        faraday.response :mashify
        faraday.response :json
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def rate_limit
      sleep 0.33
      yield
    end
  end

  class ApiKeyMissing < StandardError; end;
  class InvalidApiKey < StandardError; end;
end
