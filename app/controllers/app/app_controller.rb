# frozen_string_literal: true

class App::AppController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_app_admin!
  before_action :set_institution
  before_action :set_branches

  private

  def set_branches
    @current_branch = @institution.branches.find_by(id: params[:branch_id] || params[:id] || 1)
    @branches = @institution.branches
  end

  def set_institution
    @institution = current_admin.institution
  end
end
