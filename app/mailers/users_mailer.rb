class UsersMailer < ApplicationMailer
  def email_confirmation(user_id, token)
    @user = User.find_by(id: user_id)
    @token = token

    send_mail_with_user_locale(@user.locale) do
      mail to: "#{@user.username} <#{@user.email}>", subject: subject
    end
  end

  def reset_password(user_id, token)
    @user = User.find_by(id: user_id)
    @token = token

    send_mail_with_user_locale(@user.locale) do
      mail to: "#{@user.username} <#{@user.email}>", subject: subject
    end
  end
end
