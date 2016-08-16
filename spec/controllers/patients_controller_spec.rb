require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  render_views
  describe "GET #index" do
    before do
      Patient.create!(last_name: 'Mohammed-Rabiu', first_name: 'Anissatu', dob: '01/10/1989', phone_number: '0246559067', email_address: 'anissatu@gmail.com')
      Patient.create!(last_name: "Mohammed", first_name: "Samiratu", dob: "01/10/1987", phone_number: "0246181700", email_address: "samiratu@gmail.com")
      Patient.create!(last_name: "Aziz", first_name: "Fadeelatu", dob: "10/05/1995", phone_number: "0246559067", email_address: "faisal@smsgh.com")
      Patient.create!(last_name: "Ahmed", first_name: "Wasilatu", dob: "01/09/1991", phone_number: "0246559067", email_address: "faisal@smsgh.com")
      Patient.create!(last_name: "Taha", first_name: "Rashida", dob: "01/10/1989", phone_number: "0246559067", email_address: "faisal@smsgh.com")

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) {JSON.parse(response.body)}

    def extract_last_name
      ->(object) {object["last_name"]}
    end

    context "when the search finds results" do
      let(:keywords) {'mohammed'}
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return 2 results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Mohammed-Rabiu'" do
        expect(results.map(&extract_last_name)).to include('Mohammed-Rabiu')
      end
      it "should include 'Mohammed'" do
        expect(results.map(&extract_last_name)).to include('Mohammed')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) {'Agalic'}
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
end
