# devise_token_auth/registrations
DeviseTokenAuth::RegistrationsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :registrations, 'Registrations'

  swagger_api :create do
    summary 'Register a new User'
    notes 'user register by email and password'
    param :form, 'email', :string, :optional, 'Email'
    param :form, 'password', :string, :optional, 'Password'
    param :form, 'password_confirmation', :string, :optional, 'Password Confirmation'
    response :ok, "Success", :User
    response :not_acceptable
  end
end

