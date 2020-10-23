# frozen_string_literal: true

class TeacherMailer < ApplicationMailer
  def new_account(email, pwd)
    @pwd = pwd
    mail(to: email, subject: I18n.t("utils.mailing.service_requests"))
  end
end
