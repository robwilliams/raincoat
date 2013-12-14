require 'spec_helper'

feature "Visitor getting forecast for location" do
  scenario "using a valid postcode" do
    visit "/"
    fill_in "#location__input", with: "SP4 7DE"
    click "#location__button"

    within("#forecast__current") do
      expect(page).to have_content("10c")
      expect(page).to have_content("50f")
      expect(page).to have_content("Clear")
    end
  end
end
