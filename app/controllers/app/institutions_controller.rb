# frozen_string_literal: true

class App::InstitutionsController < App::AppController
  before_action :set_institution

  def update
    @institution.update(institution_params)
    redirect_to root_path
  end

  private

    def set_institution
      @institution = current_admin.institution
    end

    def institution_params
      params.require(:institution).permit(:name)
    end
end
