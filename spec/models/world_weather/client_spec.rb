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
      it "returns the response as a hash" do
        expect(subject.get("search.ashx", q: "London")).to have_key("search_api")
      end

      it "returns the response as idiomatic ruby" do
        expect(subject.get("search.ashx", q: "London")).to respond_to("search_api")
      end
    end

    context "with an invalid api key" do
      subject { described_class.new(api_key: 'invalid') }

      describe "#get" do
        it "raises InvalidApiKey" do
          expect{ subject.get("search.ashx", q: "London") }.to(
            raise_error(InvalidApiKey)
          )
        end
      end
    end
  end
end
