# frozen_string_literal: true

class App::GradeUnitsController < App::AppController
  before_action :set_branch
  before_action :set_grade
  before_action :set_unit, only: %i[create]

  respond_to :json

  def create
    case params[:frequency]
    when "one_time"
      GradeUnitService.call(@unit.id, @grade.id,
                            grade_unit_params[:group_id],
                            grade_unit_params[:days_of_week].keys,
                            grade_unit_params[:"starts_on(1i)"],
                            grade_unit_params[:"starts_on(2i)"],
                            grade_unit_params[:"starts_on(3i)"],
                            grade_unit_params[:"starts_on(4i)"],
                            grade_unit_params[:"starts_on(5i)"],
                            grade_unit_params[:"ends_on(1i)"],
                            grade_unit_params[:"ends_on(2i)"],
                            grade_unit_params[:"ends_on(3i)"],
                            grade_unit_params[:"ends_on(4i)"],
                            grade_unit_params[:"ends_on(5i)"]).create
    when "weekly"
      GradeUnitService.call(@unit.id, @grade.id,
                            grade_unit_params[:group_id],
                            grade_unit_params[:days_of_week].keys,
                            grade_unit_params[:"starts_on(1i)"],
                            grade_unit_params[:"starts_on(2i)"],
                            grade_unit_params[:"starts_on(3i)"],
                            grade_unit_params[:"starts_on(4i)"],
                            grade_unit_params[:"starts_on(5i)"],
                            grade_unit_params[:"ends_on(1i)"],
                            grade_unit_params[:"ends_on(2i)"],
                            grade_unit_params[:"ends_on(3i)"],
                            grade_unit_params[:"ends_on(4i)"],
                            grade_unit_params[:"ends_on(5i)"]).create_weekly
    when "biweekly"
      GradeUnitService.call(@unit.id, @grade.id,
                            grade_unit_params[:group_id],
                            grade_unit_params[:days_of_week].keys,
                            grade_unit_params[:"starts_on(1i)"],
                            grade_unit_params[:"starts_on(2i)"],
                            grade_unit_params[:"starts_on(3i)"],
                            grade_unit_params[:"starts_on(4i)"],
                            grade_unit_params[:"starts_on(5i)"],
                            grade_unit_params[:"ends_on(1i)"],
                            grade_unit_params[:"ends_on(2i)"],
                            grade_unit_params[:"ends_on(3i)"],
                            grade_unit_params[:"ends_on(4i)"],
                            grade_unit_params[:"ends_on(5i)"]).create_biweekly
    end
    redirect_to app_institutions_branch_grade_path(@branch, @grade)
  end

  # TODO: esta rota carrega duas vezes, eliminar chamda ajax nela
  def show
    @grade_units = @grade.grade_units.includes(:teachers).find_by(id: params[:id])
    respond_with @grade_units
  end

  def destroy
    @grade_unit = @grade.grade_units.find_by(id: params[:id]).destroy
    redirect_to app_institutions_branch_grade_path(@branch, @grade)
  end

  private

  def set_unit
    @unit = @branch.units.find_by!(id: grade_unit_params[:unit_id] || params[:unit_id])
  end

  def set_grade
    @grade = @branch.grades.find_by!(id: params[:grade_id] || grade_unit_params[:grade_id])
  end

  def set_branch
    @branch = current_admin.institution.branches.find_by(id: params[:branch_id])
  end

  def grade_unit_params
    params.require(:grade_unit).permit(:unit_id, :group_id, :grade_id, :starts_on, :ends_on, days_of_week: {})
  end
end
