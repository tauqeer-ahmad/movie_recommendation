class MoviesController < ApplicationController
  before_filter :get_user
  def index
    @movies = @user.movies.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movies }
    end
  end

  def show
    @movie = Movie.find(params[:id])

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
        format.html { redirect_to [@user, @movie], notice: 'Movie was successfully created.' }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { render action: "new" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @movie = @user.movies.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to [@user, @movie], notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie = @user.movies.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  private

  def get_user
    @user = User.find params[:user_id]
  end
end
