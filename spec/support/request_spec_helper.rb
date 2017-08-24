module RequestSpecHelper
  def login(user)
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end
end
