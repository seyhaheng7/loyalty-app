# devise_token_auth/registrations
DeviseTokenAuth::RegistrationsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :registrations, 'Registrations'

  swagger_api :update do
    summary 'edit User Profile'
    param :header, 'access-token', :string, :required, 'Authentication token'
    param :header, 'token-type', :string, :required, 'Bearer'
    param :header, 'client', :string, :required, 'Simultaneous sessions on different clients'
    param :header, 'expiry', :string, :required, 'The date at which the current session will expire'
    param :header, 'uid', :string, :required, 'A unique value that is used to identify the user'
    param :form, 'name', :string, :optional, 'Name'
    param :form, 'gender', :string, :optional, 'Gender'
    param :form, 'avatar', :string, :optional, 'Avatar'
    param :form, 'phone', :string, :optional, 'Phone'
    param :form, 'address', :string, :optional, 'Address'
    param :form, 'lat', :float, :optional, 'Lat'
    param :form, 'long', :float, :optional, 'Long'
    param :form, 'email', :string, :optional, 'Email'
    response :ok, "Success", :User
    response :not_acceptable
  end
end

