class ApplicationMailer < ActionMailer::Base
  layout "mailer"
  default from: "Open Idea Station <help@open-idea-station.io>"

  def subject(values = {})
    I18n.interpolate(default_i18n_subject, values)
  end

  def send_mail_with_user_locale(user_locale, &block)
    I18n.with_locale(user_locale, &block)
  end
end
