require 'spec_helper'

feature "Visitor getting forecast for location", vcr: true do
  scenario "using a valid postcode" do
    visit "/"
    fill_in "location_input", with: "SP4 7DE"
    click_button "location_button"

    within("#forecast_current") do
      expect(page).to have_content("12")
      expect(page).to have_content("54")
      expect(page).to have_content("Moderate rain")
    end
  end

  scenario "using a valid location" do
    visit "/"
    fill_in "location_input", with: "Birmingham, United Kingdom"
    click_button "location_button"

    {
      current: { c: "13", f: "55", condition: "Partly Cloudy"},
      one:     { c: "10", f: "50", condition: "Partly Cloudy"},
      two:     { c: "10", f: "50", condition: "Partly Cloudy"},
      three:   { c: "10", f: "50", condition: "Partly Cloudy"},
      four:    { c: "10", f: "50", condition: "Partly Cloudy"},
      five:    { c: "10", f: "50", condition: "Partly Cloudy"},
    }.each do |key, values|

      within("#forecast_#{key}") do
        values.each{|_, value| expect(page).to have_content(value) }
      end
    end
  end

  scenario "using an invalid location" do
    visit "/"
    fill_in "location_input", with: "480938205820985092385"
    click_button "location_button"

    expect(page).to have_content("Please enter a valid location")
  end

  scenario "using an empty location" do
    visit "/"
    fill_in "location_input", with: ""
    click_button "location_button"

    expect(page).to have_content("Please enter a location")
  end
end
