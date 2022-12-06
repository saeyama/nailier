# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'nailier <noreply@nailier.net>'
  layout 'mailer'
end
