class Song < ApplicationRecord
  belongs_to :anime
  delegate :animetitle, :to => :anime
  self.per_page = 30
end
