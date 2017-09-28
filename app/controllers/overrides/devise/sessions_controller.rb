module Overrides::Devise
  class SessionsController < Devise::SessionsController
    after_action :add_device, only: :create
    after_action :destroy_device, only: :destroy

    private

    def destroy_device
      device.destroy if device.present?
    end

    def add_device
      if params[:device_id].present?
        if device.present?
          device.update(deviceable: current_user)
        else
          current_user.devices.create(device_id: params[:device_id])
        end
        session[:device_id] = params[:device_id]
      end
    end

    def device
      @device ||= Device.find_by(device_id: params[:device_id])
    end
  end
end
