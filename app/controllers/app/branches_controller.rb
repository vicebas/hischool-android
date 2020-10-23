# frozen_string_literal: true

class App::BranchesController < App::AppController
  before_action :set_branch, except: %i[new create]

  def new
    @branch = current_admin.institution.branches.build
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to root_path, notice: { success: I18n.t("activerecord.info.models.branch.success") }
    else
      redirect_to root_path, notice: { error: I18n.t("activerecord.info.models.branch.error") }
    end
  end

  def show
    redirect_to root_path unless @branch.present?
  end

  def update
    @branch.update(branch_params)
    redirect_to app_institutions_branch_path(@branch)
  end

  private

  def set_branch
    @branch = current_admin.institution.branches.find_by(id: params[:id])
  end

  def branch_params
    params.require(:branch).permit(:name, :code, :lat, :long, :institution_id,
                                   :cep, :address_number, :complement, :neighborhood,
                                   :federation_id, :city, :street)
  end
end
