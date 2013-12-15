require 'spec_helper'

def json_fixture(file_name)
  JSON.parse(open(File.join(Rails.root, 'spec/fixtures', file_name)).read)
end

module WorldWeather
  describe Response do
    subject { described_class.new(response) }

    context "with valid response" do
      let(:response) { json_fixture('valid_weather_data.json') }

      it "is successful" do
        expect(subject).to be_success
      end

      {
        temp_c: "13",
        temp_f: "55",
        description: "Partly Cloudy",
      }.each do |key, value|
        describe "##{key}" do
          it "equals #{value}" do
            expect(subject.send(key).to_s).to eq(value)
          end
        end
      end

      describe "forecasts" do
        it "has the next 5 days weather" do
          expect(subject.count).to eq(5)
        end

        describe "#first" do
          it "has an icon_url" do
            expect(subject.first.icon_url).to eq("http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0003_white_cloud.png")
          end

          it "has a date" do
            expect(subject.first.date).to be_a(Date)
          end

          it "has temp_min_c" do
            expect(subject.first.temp_min_c).to eq("10")
          end

          it "has temp_max_c" do
            expect(subject.first.temp_max_c).to eq("12")
          end
        end
      end
    end

    context "with invalid data" do
      let(:response) { json_fixture('invalid_weather_data.json') }
      it "is not successful" do
        expect(subject).to_not be_success
      end
    end
  end
end
