class Comment < ApplicationRecord
  ACTION = :commented

  include UniqueIdentifier

  include Notifiable

  belongs_to :idea
  belongs_to :user

  def prepare_recipients
    idea_commenters = []
    Idea.find_by(id: idea_id).comments.each do |commenter|
      idea_commenters.push(User.find_by(id: commenter[:user_id]))
    end

    idea_commenters.uniq - [user]
  end

  def uid_prefix
    "com"
  end
end
