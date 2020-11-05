# frozen_string_literal: true

class App::TeachersController < App::AppController
  before_action :set_teacher, only: %i[show update clock_ins]
  before_action :set_default_branch

  def index
    @teachers = @institution.teachers.includes(:user).page(params[:page] || 1)
  end

  def new
    @teacher = @institution.teachers.build
    @teacher.build_user
  end

  def create
    if TeacherService.call(teacher_params)
      redirect_to app_institutions_teachers_path, notice: { success: I18n.t("activerecord.info.models.teacher.create.success") }
    else
      redirect_to app_institutions_teachers_path, notice: { error: I18n.t("activerecord.info.models.teacher.create.error") }
    end
  end

  def show
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to app_institutions_teachers_path, notice: { success: I18n.t("activerecord.info.models.teacher.update.success") }
    else
      redirect_to app_institutions_teachers_path, notice: { error: I18n.t("activerecord.info.models.teacher.update.error") }
    end
  end

  def new_spreadsheet
  end

  def upload_spreadsheet
    if TeacherSpreadsheetService.call(params[:file], @institution.id)
      redirect_to app_institutions_teachers_path, notice: { success: I18n.t("activerecord.info.models.teacher.spreadsheet.upload.success") }
    else
      redirect_to app_institutions_teachers_path, notice: { error: I18n.t("activerecord.info.models.teacher.spreadsheet.upload.error") }
    end
  end

  def clock_ins
    # TODO: refatorar para eliminar queries n+1
    @clock_ins = GradeUnitDecorator.decorate_collection(@teacher.grade_units.includes(:grade, :unit).joins(:grade_unit_teachers).where("grade_unit_teachers.teacher_clock_in is not null"))
  end

  private

  def set_default_branch
    @current_branch = @institution.branches.first
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    teacher_param = params.require(:teacher).permit(:name, :tax_id, :cellphone, :institution_id, :"birthdate(3i)", :"birthdate(2i)", :"birthdate(1i)", user_attributes: [:id, :email])
    teacher_param[:user_attributes][:tax_id] = teacher_param[:tax_id]
    teacher_param.delete(:tax_id)
    teacher_param
  end
end
