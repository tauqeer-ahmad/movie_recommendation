class UsersController < ApplicationController
  before_filter :get_user, :only => [:show]
  before_filter :authenticate_user!

  def show
    @movies = @user.movies
    @liked_movies = User.first.votes.collect(&:voteable)
  end

  private

  def get_user
    @user = User.find params[:id]
  end
end
