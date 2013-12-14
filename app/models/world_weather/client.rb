require 'world_weather'

module WorldWeather
  class Client

    def initialize(options = {})
      options = {} if options.nil?
      @endpoint = options.fetch(:endpoint, WorldWeather::DEFAULT_ENDPOINT)
      begin
        @api_key  = options.fetch(:api_key)
      rescue KeyError
        raise ApiKeyMissing, ":api_key should be a Free World Weather API key"
      end
    end

    def get(path, params={})
      params.merge!(key: api_key, format: 'JSON')
      connection.get(path, params).body
    rescue Faraday::Error::ParsingError
      raise InvalidApiKey, ":api_key is invalid"
    end

    private
    attr_reader :endpoint, :api_key

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
