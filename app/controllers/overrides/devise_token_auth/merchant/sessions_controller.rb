module Overrides::DeviseTokenAuth::Merchant
  class SessionsController < DeviseTokenAuth::SessionsController
    around_action :destroy_device, only: :destroy
    around_action :add_device, only: :create

    def create
      # Check
      field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first

      @resource = nil
      if field
        q_value = resource_params[field]

        if resource_class.case_insensitive_keys.include?(field)
          q_value.downcase!
        end
        # merchant use phone provider
        q = "#{field.to_s} = ? AND provider='#{provider}'"

        if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
          q = "BINARY " + q
        end


        @resource = resource_class.where(q, q_value).first
      end

      if @resource and valid_params?(field, q_value) and @resource.valid_password?(resource_params[:password]) and (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
        # create client id
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?

        # update auth header manaully
        update_auth_header

        render_create_success
      elsif @resource and not (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
        render_create_error_not_confirmed
      else
        render_create_error_bad_credentials
      end
    end

    protected
    def provider
      'phone'
    end

    private

    def destroy_device
      device.destroy if device.present?
    end

    def add_device
      if params[:device_id].present?
        if device.present?
          device.update(deviceable: @resource)
        else
          @resource.devices.create(device_id: params[:device_id])
        end
        session[:device_id] = params[:device_id]
      end
    end

    def device
      return if @resource.blank?
      @device ||= @resource.devices.find_by(device_id: params[:device_id])
    end
  end
end
