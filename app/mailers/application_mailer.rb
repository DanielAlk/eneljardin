class ApplicationMailer < ActionMailer::Base
  default from: %("En el jardín | Clara Billoch" <#{ENV['notifications_mailer_username']}>)
  layout 'mailer'
end
