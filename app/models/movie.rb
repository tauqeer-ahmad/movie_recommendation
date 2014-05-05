class Movie < ActiveRecord::Base
  attr_accessible :title, :year

  belongs_to :user

  validates :title, :year, presence: true

  def display_year
    year.to_date.year if year.present?
  end
end
