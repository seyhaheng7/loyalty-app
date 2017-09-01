# devise_token_auth/registrations
# DeviseTokenAuth::RegistrationsController.class_eval do
#   Swagger::Docs::Generator::set_real_methods
#   swagger_controller :registrations, 'Registrations'

#   swagger_api :create do
#     summary 'Register a new User'
#     notes 'user register by email and password'
#     param :form, 'phone', :string, :required, 'Phone Number'
#     param :form, 'password', :string, :required, 'Password'
#     param :form, 'password_confirmation', :string, :required, 'Password Confirmation'
#     response :ok, "Success", :User
#     response :not_acceptable
#   end
# end



Overrides::DeviseTokenAuth::RegistrationsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :registrations, 'Registrations'

  swagger_api :create do
    summary 'Register a new User'
    notes 'user register by email and password'
    param :form, 'phone', :string, :required, 'Phone Number'
    param :form, 'password', :string, :required, 'Password'
    param :form, 'password_confirmation', :string, :required, 'Password Confirmation'
    response :ok, "Success", :User
    response :not_acceptable
  end
end

