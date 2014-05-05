class MovieGenre < ActiveRecord::Base
  attr_accessible :genre_id, :movie_id

  belongs_to :movie
  belongs_to :genre
end
