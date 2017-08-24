email = 'info@codingate.com'
user = User.find_by email: email
if user.present?
  user = User.new email: 'info@codingate.com', password: 'Codingate@2017'
  user.save
end
