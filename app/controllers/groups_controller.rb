class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @shared = shared(default: true)
    @transactions = transactions
    @balance = @transactions.balance
  end

  def new
    @group = Group.new
    @group.users.build(email: params[:email])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group.slug)
    else
      render :new
    end
  end

  def user_row
  end

  private

  def group_params
    params.require(:group).permit(:name, users_attributes: [:email, :name])
  end

  def transactions
    result = @group.transactions.order(date: :desc, created_at: :desc).send(timing)
    result = result.shared if @shared
    result
  end
end
