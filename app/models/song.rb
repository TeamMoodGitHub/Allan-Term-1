class Song < ApplicationRecord
  belongs_to :anime
  delegate :animetitle, :to => :anime
end
