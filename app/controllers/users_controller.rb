class UsersController < ApplicationController
  def show
    @user = User.find_by(slug: params[:id].downcase)
  end
end
