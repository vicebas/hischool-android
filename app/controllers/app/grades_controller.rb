# frozen_string_literal: true

class App::GradesController < App::AppController
  before_action :set_branch
  before_action :set_grade, only: %i[show update course_filter teacher_filter unit_filter]
  before_action :set_filters, only: %i[course_filter teacher_filter unit_filter show]

  def index
    @grades = @branch.grades.page(params[:page] || 1)
  end

  def show
    @grade_units = @grade.grade_units.includes(unit: [:course], teachers: [])
    respond_with @grade_units
  end

  def course_filter
    @grade_units = @grade.grade_units
                         .includes(unit: [:course], teachers: [])
                         .joins(:unit)
                         .where("units.course_id = ?", params[:course_id])
    @course = @courses.find_by(id: params[:course_id])
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @grade_units }
    end
  end

  def teacher_filter
    @grade_units = @grade.grade_units
                         .includes(unit: [:course], teachers: [])
                         .joins(:teachers)
                         .where("teachers.id = ?", params[:teacher_id])
    @teacher = @teachers.find_by(id: params[:teacher_id])
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @grade_units }
    end
  end

  def unit_filter
    @grade_units = @grade.grade_units
                         .includes(unit: [:course], teachers: [])
                         .where("unit_id = ?", params[:unit_id])
    @unit = @units.find_by(id: params[:unit_id])
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @grade_units }
    end
  end

  def update
    if @grade.update(grade_params)
      redirect_to app_institutions_branch_grade_path(@branch), notice: { success: I18n.t("activerecord.info.models.grade.create.success") }
    else
      redirect_to app_institutions_branch_grade_path(@branch), notice: { error: I18n.t("activerecord.info.models.grade.create.error") }
    end
  end

  private

  def grade_params
    params.require(:grade).permit(:title, :begin_date, :end_date, :branch_id)
  end

  def set_grade
    @grade = @branch.grades.find_by!(id: params[:id])
  end

  def set_branch
    @branch = current_admin.institution.branches.find_by(id: params[:branch_id])
  end

  def set_filters
    @courses = @branch.courses
    @units = @branch.units
    @teachers = @institution.teachers
    @grade_unit = @grade.grade_units.new
  end

  def json_request?
    request.format.symbol == :json
  end
end
