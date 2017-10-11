# need to do class eval because skip authentication
Overrides::DeviseTokenAuth::Merchant::SessionsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :merchant_logins, 'Merchant Authentication'
  swagger_api :create do
    summary 'Merchant Login '
    notes 'user login with phone and password'
    param :form, 'phone', :string, :required, 'Phone Number'
    param :form, 'password', :string, :required, 'Password'
    param :form, 'device_id', :string, :optional, 'One signal device id'
    response :ok, "Success", :User
    response :not_acceptable
  end

  swagger_api :destroy do
    summary 'Destroy merchant session'
    notes 'merchant sign out'
    param :form, 'uid', :string, :required, 'Uid'
    param :form, 'access-token', :string, :required, 'Access-Token'
    param :form, 'client', :string, :required, 'Client'
    param :form, 'expiry', :string, :required, 'Expiry'
    param :form, 'token-type', :string, :required, 'Token Type'
    param :form, 'device_id', :string, :optional, 'One signal device id'
    response :not_found
    response :ok, "Success", :User
    response :not_acceptable
  end
end


Overrides::DeviseTokenAuth::Merchant::RegistrationsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :registrations, 'Merchant Registrations'

  swagger_api :update do
    summary 'edit User Profile'
    param :header, 'access-token', :string, :required, 'Authentication token'
    param :header, 'token-type', :string, :required, 'Bearer'
    param :header, 'client', :string, :required, 'Simultaneous sessions on different clients'
    param :header, 'expiry', :string, :required, 'The date at which the current session will expire'
    param :header, 'uid', :string, :required, 'A unique value that is used to identify the user'
    param :form, 'name', :string, :optional, 'Name'
    param :form, 'avatar', :string, :optional, 'Avatar (Base64)'
    param :form, 'email', :string, :optional, 'Email'
    param :form, 'password', :string, :optional, 'Password'
    response :ok, "Success", :User
    response :not_acceptable
  end
end
