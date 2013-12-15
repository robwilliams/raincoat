require 'spec_helper'

module WorldWeather 
  describe Weather, vcr: true do

    let(:client) { Client.new(api_key: ENV['WORLD_WEATHER_API_KEY'])}
    let(:weather) { described_class.new(client) }
    
    describe "#get" do
      subject { weather.get(location) }

      context "with valid location" do
        let(:location) { "London" }

        it "is valid" do
          expect(subject).to be_valid
        end

        it "returns the current_condition" do
          p subject
          expect(subject.current_condition).to respond_to("cloudcover")
        end

        it "returns the weather" do
          expect(subject.weather.first).to respond_to("tempMaxC")
        end
      end

      context "with invalid location" do
        let(:location) { "39187498719847591735923785" }

        it "is not valid" do
          expect(subject).to_not be_valid
        end
      end
    end
  end
end