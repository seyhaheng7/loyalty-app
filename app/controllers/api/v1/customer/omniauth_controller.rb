module Api::V1::Customer
  class OmniauthController < BaseController
    skip_before_action :authenticate_customer!
    skip_before_action :check_customer_verification!, if: :customer_signed_in?

    swagger_controller :omniauth, 'Omniauth'

    swagger_api :facebook do
      summary 'Facebook Omniauth Registration'
      param :form, 'uid', :string, :required, 'uid'
      param :form, 'provider_access_token', :string, :required, 'access token'
      param :form, 'phone', :string, :optional, 'Phone Number'
      param :form, 'first_name', :string, :optional, 'First Name'
      param :form, 'last_name', :string, :optional, 'Last Name'
      param :form, 'email', :string, :optional, 'email'
      param :form, 'gender', :string, :optional, 'Gender'
      param :form, 'avatar', :base64, :optional, 'Avatar'
      param :form, 'remote_avatar_url', :string, :optional, 'Avatar url'
      param :form, 'address', :string, :optional, 'Address'
      param :form, 'lat', :float, :optional, 'Lat'
      param :form, 'long', :float, :optional, 'Long'
      param :form, 'device_id', :string, :optional, 'One signal device id'
      response :ok, "Success", :User
      response :not_acceptable
    end

    swagger_api :google do
      summary 'google Omniauth Registration'
      param :form, 'uid', :string, :required, 'uid'
      param :form, 'provider_access_token', :string, :required, 'access token'
      param :form, 'phone', :string, :optional, 'Phone Number'
      param :form, 'first_name', :string, :optional, 'First Name'
      param :form, 'last_name', :string, :optional, 'Last Name'
      param :form, 'email', :string, :optional, 'email'
      param :form, 'gender', :string, :optional, 'Gender'
      param :form, 'avatar', :base64, :optional, 'Avatar'
      param :form, 'remote_avatar_url', :string, :optional, 'Avatar url'
      param :form, 'address', :string, :optional, 'Address'
      param :form, 'lat', :float, :optional, 'Lat'
      param :form, 'long', :float, :optional, 'Long'
      param :form, 'device_id', :string, :optional, 'One signal device id'
      response :ok, "Success", :User
      response :not_acceptable
    end

    def facebook
      uid = omniauth_params[:uid]
      customer = Customer.facebook_providers.find_by(uid: uid)
      if customer.blank?
        customer = Customer.new(omniauth_params.merge(provider: 'facebook', password: Devise.friendly_token))
      end

      if !customer.unverified?
        customer.assign_attributes(omniauth_params.merge(provider: 'facebook', password: Devise.friendly_token))
      end

      if customer.save
        @resource = customer
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?

        add_device
        update_auth_header
        render json: customer , status: 200
      else
        # binding.pry
        render json: {
          errors: customer.errors.full_messages
        }, status: 401
      end

    end

    def google
      uid = omniauth_params[:uid]
      customer = Customer.google_providers.find_by(uid: uid)
      if customer.blank?
        customer = Customer.new(omniauth_params.merge(provider: 'google', password: Devise.friendly_token))
      end

      if !customer.unverified?
        customer.assign_attributes(omniauth_params.merge(provider: 'facebook', password: Devise.friendly_token))
      end

      if customer.save
        @resource = customer
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?
        add_device
        update_auth_header

        render json: { data: customer }, status: :success
      else
        render json: {
          errors: customer.errors.full_messages
        }, status: 401
      end
    end


    private

    def omniauth_params
      params.permit(
        :email, :phone, :registration, :first_name, :last_name, :gender, :avatar, :address, :lat, :long, :remote_avatar_url, :uid, :provider_access_token
      )
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
