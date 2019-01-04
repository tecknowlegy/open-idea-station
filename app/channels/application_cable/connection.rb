module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", current_user[:username]
    end

    protected

    def find_verified_user
      @verified_user ||= User.find_user_by_session(cookies[:user_id]) if Acorn::AuthorizeUserService.new(cookies[:user_id]).call.result

      # Raises ActionCable::Connection::Authorization::UnauthorizedError
      @verified_user || reject_unauthorized_connection
    end
  end
end
