class Movie < ActiveRecord::Base
  attr_accessible :title, :year, :genre_ids
  attr_accessor :genre_ids

  acts_as_voteable

  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres

  belongs_to :user

  validates :title, :year, presence: true

  def display_year
    year.to_date.year if year.present?
  end

  def display_genres
    genres.collect(&:name).to_a.join(', ')
  end

  def display_title
    title.to_s.titleize
  end

  def add_genres(genre_ids)
    return if genre_ids.blank?
    self.genres.delete_all
    genre_ids.each do |genre_id|
      next if genre_id.blank?
      self.movie_genres.create(:movie_id => self.id, :genre_id => genre_id)
    end
  end
end
