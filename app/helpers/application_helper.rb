# frozen_string_literal: true

module ApplicationHelper
  def current_admin
    current_app_admin
  end

  def destroy_admin_session_path
    destroy_app_admin_session_path
  end
end
