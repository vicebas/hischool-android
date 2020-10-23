# frozen_string_literal: true

class TeacherService < ApplicationService
  def initialize(teacher_params)
    @user_pwd = SecureRandom.hex(5)
    @teacher_params = teacher_params
  end

  def call
    begin
      create_teacher
      send_email
      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  end

  def create_teacher
    @teacher_params[:user_attributes][:password] = @user_pwd
    @teacher = Teacher.create!(@teacher_params)
  end

  def send_email
    TeacherMailer.new_account(@teacher.email, @user_pwd).deliver_now
  end
end
