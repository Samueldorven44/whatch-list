class List < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_one_attached :photo
end
