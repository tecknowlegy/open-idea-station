class UsersMailerPreview < ActionMailer::Preview
  def initialize
    @user = User.first
    @ip = "127.0.0.1"
  end

  def email_confirmation
    token = Acorn::JsonWebToken.encode({ data: [@user.id, @user.email] }, 2.hours.from_now)

    UsersMailer.email_confirmation(@user.id, token)
  end
end
