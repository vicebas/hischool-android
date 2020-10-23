# frozen_string_literal: true

class App::DashboardController < App::AppController
  def index
  end

  def branch
    redirect_to app_institutions_branch_path(@current_branch)
  end
end
