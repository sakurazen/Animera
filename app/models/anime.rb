class Anime < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :anime_score, presence: true, numericality: true, length: { maximum: 255 }
  has_many :reviews, dependent: :destroy
end
