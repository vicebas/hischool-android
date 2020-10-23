# frozen_string_literal: true

class App::CoursesController < App::AppController
  before_action :set_branch
  before_action :set_course, only: %i[show update units_codes]

  def index
    @courses = @branch.courses.page(params[:page] || 1)
  end

  def new
    @course = @branch.courses.build
  end

  def show
    @units = @course.units
    respond_with @units
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to app_institutions_branch_courses_path(@branch), notice: { success: I18n.t("activerecord.info.models.course.create.success") }
    else
      redirect_to app_institutions_branch_courses_path(@branch), notice: { error: I18n.t("activerecord.info.models.course.create.error") }
    end
  end

  def update
    if @course.update(course_params)
      redirect_to app_institutions_branch_course_path(@branch), notice: { success: I18n.t("activerecord.info.models.course.update.success") }
    else
      redirect_to app_institutions_branch_course_path(@branch), notice: { error: I18n.t("activerecord.info.models.course.update.error") }
    end
  end

  def units_codes
    @unit_codes = @course.units.map { |unit| [unit.id, unit.name] }
    respond_with @unit_codes
  end

  private

  def set_course
    @course = @branch.courses.find_by(id: params[:id])
  end

  def set_branch
    @branch = current_admin.institution.branches.find_by(id: params[:branch_id])
  end

  def course_params
    params.require(:course).permit(:code, :name, :branch_id, units_attributes: [])
  end
end
