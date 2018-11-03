module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", current_user[:username]
    end

    protected

    def find_verified_user
      # Assuming a successful authentication sets a signed cookie with the `user_id`
      if verified_user = User.find_by(id: cookies.signed[:user_id])
        verified_user
      else
        # Raises ActionCable::Connection::Authorization::UnauthorizedError
        reject_unauthorized_connection
      end
    end
  end
end
