require 'spec_helper'

feature "Visitor getting forecast for location" do
  scenario "using a valid postcode" do
    visit "/"
    fill_in "location_input", with: "SP4 7DE"
    click_button "location_button"

    within("#forecast_current") do
      expect(page).to have_content("10c")
      expect(page).to have_content("50f")
      expect(page).to have_content("Clear")
    end
  end

  scenario "using a valid location" do
    visit "/"
    fill_in "location_input", with: "Birmingham, United Kingdom"
    click_button "location_button"

    within("#forecast_current") do
      expect(page).to have_content("11c")
      expect(page).to have_content("52f")
      expect(page).to have_content("Partly Cloudy")
    end
  end

  scenario "using an empty location" do
    visit "/"
    fill_in "location_input", with: ""
    click_button "location_button"

    expect(page).to have_content("Please enter a location")
  end
end
