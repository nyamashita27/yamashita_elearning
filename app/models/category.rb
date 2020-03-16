class Category < ApplicationRecord
    validates :title, presence: true, length: { minimum: 3, maximun:40 }
    validates :description, presence: true, length: { maximum: 100 }
end
