class PagesController < ApplicationController
  def home
  end

  def clear
    render ClearComponent.new(frame: params[:frame])
  end
end
