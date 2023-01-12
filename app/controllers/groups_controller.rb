class GroupsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :user_row]

  def show
    @group = current_user.group
    @shared = shared(default: true)
    @timing = timing
  end

  def new
    @group = Group.new
    @group.users.build(email: params[:email])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      auto_login(@group.users.first)
      @group.users.drop(1).each{|u| u.deliver_magic_login_instructions!}
      redirect_to group_path(@group.slug)
    else
      render :new
    end
  end

  def user_row
    index = params[:index]&.to_i
    render turbo_stream: [
      turbo_stream.append("users", partial: 'groups/user_row', locals: {index: index} ),
      turbo_stream.update("new-user-button", partial: 'groups/user_button', locals: {index: index + 1} )
    ]
  end

  private

  def group_params
    params.require(:group).permit(:name, users_attributes: [:email, :name])
  end
end
