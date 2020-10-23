# frozen_string_literal: true

class App::UnitsController < App::AppController
  before_action :set_branch
  before_action :set_unit, only: %i[show update destroy]
  before_action :set_course, only: %i[new show update create destroy]

  def new
    @unit = @branch.units.build
    @unit.course = @course
  end

  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      redirect_to app_institutions_branch_course_path(@branch, @course), notice: { success: I18n.t("activerecord.info.models.unit.create.success") }
    else
      redirect_to app_institutions_branch_course_path(@branch, @course), notice: { error: I18n.t("activerecord.info.models.unit.create.error") }
    end
  end

  def index
    @units = @branch.units
  end

  def show
  end

  def update
    if @unit.update(unit_params)
      redirect_to app_institutions_branch_course_unit_path(@branch, @course, @unit), notice: { success: I18n.t("activerecord.info.models.unit.update.success") }
    else
      redirect_to app_institutions_branch_course_unit_path(@branch, @course, @unit), notice: { error: I18n.t("activerecord.info.models.unit.update.error") }
    end
  end

  def destroy
    # TODO: fazer verificações de segurança para não excluir relações com dependências
    if @unit.destroy
      redirect_to app_institutions_branch_course_path(@branch, @course), notice: { success: I18n.t("activerecord.info.models.unit.destroy.success") }
    else
      redirect_to app_institutions_branch_course_path(@branch, @course), notice: { error: I18n.t("activerecord.info.models.unit.destroy.error") }
    end
  end

  private

  def set_unit
    @unit = @branch.units.find_by(id: params[:id])
  end

  def set_course
    @course = @branch.courses.find_by(id: params[:course_id])
  end

  def set_branch
    @branch = current_admin.institution.branches.find_by(id: params[:branch_id])
  end

  def unit_params
    params.require(:unit).permit(:code, :name, :branch_id, :course_id, :kind)
  end
end
