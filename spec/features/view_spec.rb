require 'rails_helper'

feature "Viewing a patient", js: true do
  before do
    Patient.create!(last_name: 'Mohammed-Rabiu', first_name: 'Anissatu')
    Patient.create!(last_name: 'Mohammed', first_name: 'Samiratu')
  end

  scenario "view one patient" do
    visit '/'
    fill_in "keywords", with: "Mohammed-Rabiu"
    click_on "Search"

    click_on "Mohammed-Rabiu Anissatu"
    expect(page).to have_content("Mohammed-Rabiu Anissatu")
    expect(page).to_not have_content("Samiratu")

    click_on "Back"
    expect(page).to have_content("Mohammed-Rabiu Anissatu")
    expect(page).to_not have_content("Samiratu")
  end
end