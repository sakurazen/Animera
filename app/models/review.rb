class Review < ApplicationRecord
  belongs_to :user
  belongs_to :anime
  
  validates :episode_no, :episode_score, presence: true, numericality: true, length: { maximum: 255 }
  validates :comment, presence: true, length: { maximum: 1000 }
end
