class Lesson < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :words, through: :answers #lessonとwordsがanswer通して繋がる
  has_many :choices, through: :answers
  has_one :activity, as: :action, dependent: :destroy

  def next_word
    (category.words - words).first
  end
  
  def lesson_results
    choices.where(correct: true).count
  end
end
