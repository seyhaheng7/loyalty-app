# need to do class eval because skip authentication
Overrides::DeviseTokenAuth::Customer::SessionsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :customer_logins, 'Customer Authentication'

  swagger_api :create do
    summary 'Customer Login '
    notes 'user login with phone and password'
    param :form, 'phone', :string, :required, 'Phone Number'

    param :form, 'digit', :string, :required, 'Login Digit'
    param :form, 'device_id', :string, :optional, 'One signal device id'
    response :ok, "Success", :User
    response :not_acceptable
  end

  swagger_api :destroy do
    summary 'Destroy customer session'
    notes 'merchant sign out'
    param :form, 'uid', :string, :optional, 'Uid'
    param :form, 'access-token', :string, :optional, 'Access-Token'
    param :form, 'client', :string, :optional, 'Client'
    param :form, 'device_id', :string, :optional, 'One signal device id'
    response :not_found
    response :ok, "Success", :User
    response :not_acceptable
  end
end

Overrides::DeviseTokenAuth::Customer::RegistrationsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :registrations, 'Customer Registrations'

  swagger_api :create do
    summary 'Customer Registrations '
    notes 'user login with phone and password'
    param :form, 'phone', :string, :required, 'Phone Number'
    param :form, 'first_name', :string, :optional, 'First Name'
    param :form, 'last_name', :string, :optional, 'Last Name'
    param :form, 'email', :string, :optional, 'email'
    param :form, 'gender', :string, :optional, 'Gender'
    param :form, 'avatar', :base64, :optional, 'Avatar'
    param :form, 'address', :string, :optional, 'Address'
    param :form, 'lat', :float, :optional, 'Lat'
    param :form, 'long', :float, :optional, 'Long'
    response :ok, "Success", :User
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Edit Customer Profile'
    param :header, 'access-token', :string, :required, 'Authentication token'
    param :header, 'token-type', :string, :required, 'Bearer'
    param :header, 'client', :string, :required, 'Simultaneous sessions on different clients'
    param :header, 'expiry', :string, :required, 'The date at which the current session will expire'
    param :header, 'uid', :string, :required, 'A unique value that is used to identify the user'
    param :form, 'phone', :string, :required, 'Phone Number'
    param :form, 'first_name', :string, :optional, 'First Name'
    param :form, 'last_name', :string, :optional, 'Last Name'
    param :form, 'gender', :string, :optional, 'Gender'
    param :form, 'avatar', :string, :optional, 'Avatar'
    param :form, 'address', :string, :optional, 'Address'
    param :form, 'lat', :float, :optional, 'Lat'
    param :form, 'long', :float, :optional, 'Long'
    param :form, 'email', :string, :optional, 'Email'
    response :ok, "Success", :User
    response :not_acceptable
  end
end

