class UsersController < ApplicationController
  before_filter :get_user, :only => [:show]

  def show
  end

  private

  def get_user
    @user = User.find params[:id]
  end
end
