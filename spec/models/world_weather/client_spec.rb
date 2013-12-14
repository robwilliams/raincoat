require 'spec_helper'

module WorldWeather
  describe Client do
    subject { described_class.new(client_args) }

    context "without an api key" do
      let(:client_args) { }

      it do
        expect{ subject }.to raise_error(ApiKeyMissing)
      end
    end

    context "with an invalid api key" do
      let(:client_args) { {api_key: 'invalid'} }

      describe "#get" do
        it do
          expect{ subject.get("search.ashx", q: "London") }.to(
            raise_error(InvalidApiKey)
          )
        end
      end
    end

    context "with an api key" do
      let (:client_args) { { api_key: ENV.fetch('WORLD_WEATHER_API_KEY') } }

      describe "#get" do
        it "returns the response as a hash" do
          expect(subject.get("search.ashx", q: "London")).to have_key("search_api")
        end

        it "returns the response as idiomatic ruby" do
          expect(subject.get("search.ashx", q: "London")).to respond_to("search_api")
        end
      end
    end
  end
end
