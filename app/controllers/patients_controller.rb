class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @patients = if params[:keywords]
                  Patient.where('last_name ilike ?', "%#{params[:keywords]}%")
                else
                  []
                end
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def create
    @patient = Patient.new(params.require(:patient).permit(:last_name, :first_name))
    @patient.save
    render 'show', status: 201
  end

  def update
    patient = Patient.find(params[:id])
    patient.update_attributes(params.require(:patient).permit(:last_name, :first_name))
    head :no_content
  end

  def destroy
    patient = Patient.find(params[:id])
    patient.destroy
    head :no_content
  end
end
