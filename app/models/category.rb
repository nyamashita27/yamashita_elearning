class Category < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum:40 }
  validates :description, presence: true, length: { maximum: 100 }
  has_many :words, dependent: :destroy #we can delete single word and choices belonged to the word 
end
