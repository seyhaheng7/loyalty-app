module Api::V1::Customer
  class OperatingSystemsController < BaseController

    swagger_controller :operating_systems, 'OperatingSystems'

    def self.add_common_params(api)
      api.param :form, 'operating_system[name]', :string, :optional, 'Name'
    end

    swagger_api :create do |api|
      summary 'create a operating_system'
      notes 'make sure you pass parameters in operating_system'
      Api::V1::Customer::OperatingSystemsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end

    def create
      @operating_system = current_customer.operating_systems.new(operating_system_params)
      if @operating_system.save
         head :ok
      else
        render json: true, status: :unprocessable_entity
      end
    end

    private

      def operating_system_params
        params.require(:operating_system).permit(:name)
      end
  end
end
