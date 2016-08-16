class PatientsController < ApplicationController
  def index
    @patients = if params[:keywords]
                  Patient.where('last_name ilike ?', "%#{params[:keywords]}%")
                else
                  []
                end
  end
end
