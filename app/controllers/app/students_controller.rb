# frozen_string_literal: true

class App::StudentsController < App::AppController
  before_action :set_branch
  before_action :set_student, only: [:show, :update, :units]

  def index
    @students = @branch.students.includes(:user).page(params[:page] || 1)
  end

  def new
    @student = @branch.students.new
    @student.build_user
  end

  def show
  end

  def units
    @units = @student.grade_units.includes(:grade, :unit).select(:grade_id, :unit_id).distinct
  end

  def create
    if StudentService.call(student_params)
      redirect_to app_institutions_branch_students_path(@branch), notice: { success: I18n.t("activerecord.info.models.student.create.success") }
    else
      redirect_to app_institutions_branch_students_path(@branch), notice: { error: I18n.t("activerecord.info.models.student.create.error") }
    end
  end

  def update
    if @student.update(student_params)
      redirect_to app_institutions_branch_students_path(@branch), notice: { success: I18n.t("activerecord.info.models.student.update.success") }
    else
      redirect_to app_institutions_branch_students_path(@branch), notice: { error: I18n.t("activerecord.info.models.student.create.error") }
    end
  end

  def search
  end

  private

  def student_params
    params.require(:student).permit(:name, :enrollment_id, :cellphone, :branch_id, :"birthdate(3i)", :"birthdate(2i)", :"birthdate(1i)", user_attributes: [:id, :email, :tax_id])
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def set_branch
    @branch = current_admin.institution.branches.find_by(id: params[:branch_id])
  end
end
