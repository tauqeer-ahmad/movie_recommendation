class MoviesController < ApplicationController
  before_filter :get_user
  before_filter :get_movie, :only => [:show, :update, :edit, :destroy, :vote_up]
  before_filter :authenticate_user!
  def index
    @movies = @user.movies.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movies }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end

  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie }
    end
  end

  def edit
    @movie = @user.movies.find(params[:id])
  end

  def create
    @movie = @user.movies.new(params[:movie])

    respond_to do |format|
      if @movie.save
        @movie.add_genres(params[:movie][:genre_ids])
        format.html { redirect_to [@user, @movie], notice: 'Movie was successfully created.' }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { render action: "new" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        @movie.add_genres(params[:movie][:genre_ids])
        format.html { redirect_to [@user, @movie], notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  def vote_up
    if current_user.present?
       if current_user.voted_for?(@movie)
        current_user.unvote_for(@movie)
      else
        current_user.vote_exclusively_for(@movie)
      end
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def get_user
    @user = User.find params[:user_id]
  end

  def get_movie
    @movie = Movie.find params[:id]
  end
end
