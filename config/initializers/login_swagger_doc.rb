 # devise_token_auth/sessions#create
 DeviseTokenAuth::SessionsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :logins, 'Logins'

  swagger_api :create do
    summary 'Login a User'
    notes 'user login with email and password'
    param :form, 'email', :string, :optional, 'Email'
    param :form, 'password', :string, :optional, 'Password'
    response :ok, "Success", :User
    response :not_acceptable
  end
end
