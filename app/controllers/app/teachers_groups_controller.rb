# frozen_string_literal: true

class App::TeachersGroupsController < App::AppController
  before_action :set_branch
  before_action :set_unit
  before_action :set_course
  before_action :set_group_codes, except: %i[index]
  before_action :set_group, except: %i[new create]

  def index
    if @group.present?
      redirect_to app_institutions_branch_course_unit_teachers_group_path(@branch, @course, @unit, @group)
    else
      redirect_to new_app_institutions_branch_course_unit_teachers_group_path(@branch, @course, @unit)
    end
  end

  def show
    # TODO: me desculpa
    @groups = @unit.groups
    @teacher_ids = @group.grade_units.joins(teachers: [:user]).select("teachers.id").uniq.map { |teacher| teacher.id }
    @teachers = Teacher.where(id: @teacher_ids).includes(:user).page(params[:page] || 1)
    @empty_grade_units = @unit.grade_units.where(group: @group).empty?
  end

  def new
    @groups = @unit.groups
    @group = @unit.groups.new
  end

  def create
    @group = Group.new group_params
    if @group.save
      redirect_to app_institutions_branch_course_unit_teachers_group_path(@branch, @course, @unit, @group), notice: { success: I18n.t("activerecord.info.models.group.create.success") }
    else
      redirect_to app_institutions_branch_course_unit_teachers_groups_path(@branch, @course, @unit, @group), notice: { error: I18n.t("activerecord.info.models.group.create.error") }
    end
  end

  def groups_codes
    respond_with @groups_codes
  end

  def new_teachers
    @teacher_ids = []
    @unit.groups.each do |group|
      @teacher_ids << group.grade_units.joins(teachers: [:user]).select("teachers.id").uniq.map { |teacher| teacher.id }
    end
    @teachers = @institution.teachers.includes(:user).where.not(id: @teacher_ids.flatten.uniq).page(params[:page] || 1)
  end

  def add_teachers
    @teachers = Teacher.find(params["teacher_ids"])
    @teachers.each do |teacher|
      teacher.grade_units << @group.grade_units
    end
  end

  def remove_teacher
    @teacher = Teacher.find(params[:teacher_id])
    if @teacher.grade_units.delete(@group.grade_units)
      redirect_to app_institutions_branch_course_unit_teachers_group_path(@branch, @course, @unit, @group), notice: { success: I18n.t("activerecord.info.models.group.remove_teacher.success") }
    else
      redirect_to app_institutions_branch_course_unit_teachers_group_path(@branch, @course, @unit, @group), notice: { error: I18n.t("activerecord.info.models.group.remove_teacher.error") }
    end
  end

  private

  def set_group_codes
    @groups_codes = @unit.groups.pluck("groups.code", "groups.id")
  end

  def set_group
    @group = @unit.groups.find_by(id: params[:id]) || @unit.groups.first
  end

  def set_unit
    @unit = @branch.units.find(params[:unit_id])
  end

  def set_course
    @course = @branch.courses.find(params[:course_id])
  end

  def set_branch
    @branch = current_admin.institution.branches.find(params[:branch_id])
  end

  def group_params
    params.require(:group).permit(:unit_id, :code)
  end
end
