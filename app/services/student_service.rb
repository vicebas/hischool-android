# frozen_string_literal: true

class StudentService < ApplicationService
  def initialize(student_params)
    @user_pwd = students_params[:user_attributes][:tax_id]
    @student_params = student_params
  end

  def call
    create_student
    send_email
    true
  end

  def create_student
    @student_params[:user_attributes][:password] = @user_pwd
    @student = Student.create(@student_params)
  end

  def send_email
    StudentMailer.new_account(@student.email, @user_pwd).deliver_now
  end
end
