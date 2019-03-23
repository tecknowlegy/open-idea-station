class UsersMailerPreview < ActionMailer::Preview
  def initialize
    @user = User.first
    @ip = "127.0.0.1"
  end

  def email_confirmation
    token = Acorn::Bubble.generate([@user.id, @user.email])

    UsersMailer.email_confirmation(@user.id, token)
  end

  def reset_password
    token = Acorn::Bubble.generate([@user.id, @user.email], 1.hour.from_now)

    UsersMailer.reset_password(@user.id, token)
  end
end
