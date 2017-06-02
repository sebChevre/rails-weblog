class AdminController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to new_session_url, alert: 'Please sign in as admin!'
    end
  end
end
