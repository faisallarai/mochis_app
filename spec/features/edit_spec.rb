require 'rails_helper'

feature "Creating editing, and deleting a patient", js: true do
  scenario "CRUD a patient" do
    visit '/'
    click_on "New Patient..."

    fill_in "last_name", with: "Wilson"
    fill_in "first_name", with: "Francisca"

    click_on "Save"

    expect(page).to have_content("Wilson")
    expect(page).to have_content("Francisca")

    click_on "Edit"

    fill_in "last_name", with: "Ahmed-Taymiyya"
    fill_in "first_name", with: "Unayssa"

    click_on "Save"

    expect(page).to have_content("Ahmed-Taymiyya")
    expect(page).to have_content("Unayssa")

    visit "/"
    fill_in "keywords", with: "Ahmed-Taymiyya"
    click_on "Search"

    click_on "Ahmed-Taymiyya Unayssa"

    click_on "Delete"

    sleep 1

    expect(Patient.find_by_last_name("Ahmed-Taymiyya")).to be_nil
  end
end