class ApplicationMailer < ActionMailer::Base
  default from: '#{@user.nom} <julie.laloy@gmail.com>'
  layout 'mailer'
end
