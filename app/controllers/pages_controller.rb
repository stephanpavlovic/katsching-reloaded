class PagesController < ApplicationController
  skip_before_action :require_login

  def home
    redirect_to current_user if logged_in?
  end
end
