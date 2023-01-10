class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def shared(default:)
    @shared ||= params[:shared].present? ? ActiveModel::Type::Boolean.new.cast(params[:shared]) : default
  end

  def timing
    @timing ||= params[:timing]&.to_sym || :this_month
  end
end
