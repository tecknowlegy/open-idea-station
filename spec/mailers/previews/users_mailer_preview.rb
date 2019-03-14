class UsersMailerPreview < ActionMailer::Preview
  def initialize
    @user = User.first
    @ip = "127.0.0.1"
  end

  def email_confirmation
    token = Acorn::Bubble.generate([@user.id, @user.email])

    UsersMailer.email_confirmation(@user.id, token)
  end
end
