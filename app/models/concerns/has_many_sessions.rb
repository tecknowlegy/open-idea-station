module HasManySessions
  extend ActiveSupport::Concern

  included do
    has_many :sessions, dependent: :destroy
  end

  def all_sessions
    sessions.order(created_at: :desc)
  end

  def find_session!(id)
    # TODO: ids should point to uids in objects
    all_sessions.find_by!(id: id)
  end

  def find_session_by_token(token)
    all_sessions.find_by(token: token)
  end

  def create_session(attributes)
    sessions.create(attributes)
  end

  def revoke_all_sessions!(options = {})
    relation = sessions.active
    relation = relation.where.not(token: options[:except]) if options[:except]
    relation.map(&:revoke!)
  end
end
