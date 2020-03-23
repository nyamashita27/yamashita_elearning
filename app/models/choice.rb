class Choice < ApplicationRecord
  belongs_to :word
  validates :content, presence: true
  has_many :answers, dependent: :destroy
end
