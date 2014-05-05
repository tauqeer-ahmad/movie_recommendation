class Genre < ActiveRecord::Base
  attr_accessible :name

  has_many :movie_genres
  has_many :movies, through: :movie_genres
end
