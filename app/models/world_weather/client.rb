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
      connection.get(path, params).body
    rescue Faraday::Error::ParsingError
      raise InvalidApiKey, ":api_key is invalid"
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
  end

  class ApiKeyMissing < StandardError; end;
  class InvalidApiKey < StandardError; end;
end
