class UsersController < ApplicationController
  before_filter :get_user, :only => [:show]
  before_filter :authenticate_user!

  def show
  end

  private

  def get_user
    @user = User.find params[:id]
  end
end
