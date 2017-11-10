module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user


    def connect
      params = request.query_parameters()
      access_token = params["access-token"]
      uid = params["uid"]
      client = params["client"]
      self.current_user = find_verified_user(access_token, uid, client)
    end

    protected


    def find_verified_user(access_token, uid, client_id)
      if (current_user = env['warden'].user)
        current_user
      else
        user = Customer.find_by uid: uid
        if user.present?
          if user.valid_token?(access_token, client_id)
            user
          else
            reject_unauthorized_connection
          end
        else
          user = Merchant.find_by uid: uid
          if user.present? && user.valid_token?(access_token, client_id)
            user
          else
            reject_unauthorized_connection
          end
        end
      end
    end

  end
end
