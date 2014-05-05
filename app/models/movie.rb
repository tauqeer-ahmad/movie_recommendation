class Movie < ActiveRecord::Base
  attr_accessible :title, :year

  belongs_to :user
end
