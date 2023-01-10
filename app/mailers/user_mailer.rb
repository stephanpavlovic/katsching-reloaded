class UserMailer < ApplicationMailer
  default from: 'mail@katsching.app'

  def magic_login_email(user)
    @url = login_url(token: user.magic_login_token)
    mail(to: user.email,
      subject: 'Dein Login-Link für Katsching',
      track_opens: 'true',
      message_stream: 'outbound'
    )
  end
end
