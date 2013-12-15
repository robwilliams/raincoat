require 'spec_helper'

module WorldWeather 
  describe Weather, vcr: true do

    let(:weather) { described_class.new }
    
    describe "#get" do
      subject { weather.get(location) }

      context "with valid location" do
        let(:location) { "London" }

        it "is successful" do
          expect(subject).to be_success
        end

        it "returns a Response" do
          expect(subject).to be_a(Response)
        end
      end

      context "with invalid location" do
        let(:location) { "39187498719847591735923785" }

        it "is not valid" do
          expect(subject).to_not be_success
        end
      end
    end
  end
end
