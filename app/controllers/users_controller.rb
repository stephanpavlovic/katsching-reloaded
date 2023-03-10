class UsersController < ApplicationController
  skip_before_action :require_login, only: [:search]

  def show
    @user = User.find_by!(slug: params[:id].downcase)
    @shared = shared(default: false)
    @timing = timing
  end

  def search
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_magic_login_instructions!
      redirect_to root_path, notice: 'Du hast eine E-Mail zum Einloggen erhalten'
    else
      redirect_to new_group_path(email: params[:email])
    end
  end

  def repetitions
    @user = User.find_by!(slug: params[:id].downcase)
    @repetitions = @user.repetitions.active.order(:timing)
  end

  private

  def transactions
    result = @user.transactions
    result = result.shared if @shared
    result.order(date: :desc).send(timing)
  end
end
