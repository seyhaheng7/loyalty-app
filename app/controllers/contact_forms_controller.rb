class ContactFormsController < ApplicationController
  before_action :set_contact_form, only: [:show, :destroy]

  # GET /contact_forms
  def index
    @grid = ContactFormsGrid.new(params[:contact_forms_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /contact_forms/1
  def show
    authorize @contact_form
  end

  # DELETE /contact_forms/1
  def destroy
    @contact_form.destroy
    redirect_to contact_forms_url, notice: 'Contact Form was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_form
      @contact_form = ContactForm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_form_params
      params.require(:contact_form).permit(:subject, :message, :customer_id)
    end
end
