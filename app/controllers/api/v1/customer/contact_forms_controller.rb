module Api::V1::Customer
  class ContactFormsController < BaseController
    swagger_controller :contact_forms, 'ContactForms'

    def self.add_common_params(api)
      api.param :form, 'contact_form[subject]', :string, :required, 'Subject'
      api.param :form, 'contact_form[message]', :text, :required, 'Message'
    end

    swagger_api :create do |api|
      summary 'create a contact_form'
      notes 'make sure you pass parameters in claimed_reward'
      Api::V1::Customer::ContactFormsController::add_common_params(api)
      response :ok
    end

    def create
      @contact_form = current_user.contact_forms.new(contact_form_params)
      if @contact_form.save
        render json: @contact_form, status: :created
      else
        render json: @contact_form, status: :unprocessable_entity
      end
    end

    private
      def contact_form_params
        params.require(:contact_form).permit(:subject, :message)
      end
  end
end