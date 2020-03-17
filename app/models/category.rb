class Category < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum:40 }
  validates :description, presence: true, length: { maximum: 100 }
end
