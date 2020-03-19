class Word < ApplicationRecord
  belongs_to :category
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices
  validates :content, presence: true
  validate :has_one_correct_answer
  validate :has_unique_choice

  def correct_answer
    choices.find_by(correct: true).content
  end

  def has_one_correct_answer
    if choices.select { |choice| choice.correct? }.length != 1
      return errors.add :base, "Must have one correct answer!"
    end
  end

  def has_unique_choice

    if choices.uniq { |choice| choice.content }.length != 3
      return errors.add :base, "Must not have same answers!"
    end
  end
end
