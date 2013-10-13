class HomeController < ApplicationController
  def index
    if signed_in?
      redirect_to members_path
    end
  end
end