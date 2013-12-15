require 'spec_helper'

module WorldWeather
  describe Client, vcr: true do

    subject { described_class.new }

    describe "#endpoint" do
      it "matches the default endpoint" do
        expect(subject.endpoint).to eq(WorldWeather::ENDPOINT)
      end
    end

    describe "#api_key" do
      it "matches the environment WORLD_WEATHER_API_KEY" do
        expect(subject.api_key).to eq(ENV['WORLD_WEATHER_API_KEY'])
      end
    end

    describe "#get" do
      it "does not perform more than 3 requests per second" do
        expect do
          %w{Paris Rome Krakow Sydney Tokyo Denver Toronto}.each do |location| 
            subject.get("search.ashx", q: location)
          end
        end.to_not raise_error
      end

      it "returns the response as a hash" do
        expect(subject.get("search.ashx", q: "London")).to have_key("search_api")
      end
    end

    context "with an invalid api key" do
      subject { described_class.new(api_key: 'invalid') }

      describe "#get" do
        it "raises ApiError" do
          expect{ subject.get("search.ashx", q: "London") }.to(
            raise_error(ApiError)
          )
        end
      end
    end
  end
end
