module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", current_user[:username]
    end

    protected

    def find_verified_user
      user = Acorn::AuthorizeUserService.new(cookies[:user_id]).call.result
      return user if user

      # Raises ActionCable::Connection::Authorization::UnauthorizedError
      reject_unauthorized_connection
    end
  end
end
