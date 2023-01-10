class LoginController < ApplicationController
  skip_before_action :require_login

  def show
    @user = User.load_from_magic_login_token(params[:token])

    if @user.present?
      @user.clear_magic_login_token!
      auto_login(@user, should_remember: true)
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Erfolgreich ausgeloggt'
  end
end
