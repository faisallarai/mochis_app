require 'rails_helper.rb'

feature "Looking up patients", js: true do
  before do
    Patient.create!(last_name: 'Mohammed-Rabiu', first_name: 'Anissatu', dob: '01/10/1989', phone_number: '0246559067', email_address: 'anissatu@gmail.com')
    Patient.create!(last_name: "Mohammed", first_name: "Samiratu", dob: "01/10/1987", phone_number: "0246181700", email_address: "samiratu@gmail.com")
    Patient.create!(last_name: "Aziz", first_name: "Fadeelatu", dob: "10/05/1995", phone_number: "0246559067", email_address: "faisal@smsgh.com")
    Patient.create!(last_name: "Ahmed", first_name: "Wasilatu", dob: "01/09/1991", phone_number: "0246559067", email_address: "faisal@smsgh.com")
    Patient.create!(last_name: "Taha", first_name: "Rashida", dob: "01/10/1989", phone_number: "0246559067", email_address: "faisal@smsgh.com")
  end
  scenario "finding patients" do
    visit '/'
    fill_in "keywords", with: "Mohammed"
    click_on "Search"

    expect(page).to have_content("Mohammed-Rabiu Anissatu")
    expect(page).to have_content("Mohammed Samiratu")
  end
end