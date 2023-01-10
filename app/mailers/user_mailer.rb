class UserMailer < ApplicationMailer
  default from: 'mail@katsching.app'

  def welcome_email(user:)
    mail(to: user.email,
      subject: 'Blub',
      track_opens: 'true',
      message_stream: 'outbound'
    )
  end
end
