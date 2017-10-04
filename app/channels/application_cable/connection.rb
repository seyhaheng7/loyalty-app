module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect1
      self.current_user = find_verfied_user1
    end

    def connect
      params = request.query_parameters()
      access_token = params["access-token"]
      phone = params["phone"]
      client = params["client"]

      self.current_user = find_verified_user access_token, phone, client
    end

    protected

    def find_verfied_user1
      if current_user = env['warden'].user
        current_user
      else
        reject_unauthorized_connection
      end
    end

    def find_verified_user access_token, phone, client_id
      if (current_user = env['warden'].user)
        current_user
      else
        user = Customer.find_by phone: phone
        if user.present?
          if user && user.valid_token?(access_token, client_id)
            user
          else
            reject_unauthorized_connection
          end
        else
          user = Merchant.find_by phone: phone
          if user && user.valid_token?(access_token, client_id)
            user
          else
            reject_unauthorized_connection
          end
        end
      end
    end
    
  end
end
