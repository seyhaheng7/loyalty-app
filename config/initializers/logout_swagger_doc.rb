 # devise_token_auth/sessions#create
#  DeviseTokenAuth::SessionsController.class_eval do
#   Swagger::Docs::Generator::set_real_methods
#   swagger_controller :Logout, 'Login and Logouts'

#   swagger_api :destroy do
#     summary 'Destroy user session'
#     notes 'user sign out'
#     param :form, 'uid', :string, :optional, 'Uid'
#     param :form, 'access-token', :string, :optional, 'Access-Token'
#     param :form, 'client', :string, :optional, 'Client'
#     response :not_found
#     response :ok, "Success", :User
#     response :not_acceptable
#   end
# end


Overrides::DeviseTokenAuth::SessionsController.class_eval do
  Swagger::Docs::Generator::set_real_methods
  swagger_controller :Logout, 'Login and Logouts'

  swagger_api :destroy do
    summary 'Destroy user session'
    notes 'user sign out'
    param :form, 'uid', :string, :optional, 'Uid'
    param :form, 'access-token', :string, :optional, 'Access-Token'
    param :form, 'client', :string, :optional, 'Client'
    response :not_found
    response :ok, "Success", :User
    response :not_acceptable
  end
end
