class User < ApplicationRecord

  validates :name, presence: true, length: { minimum: 3 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, allow_nil: true #編集時にPWなくても更新できる
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  # Following Function
  # Followed Users
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  # Followers
  has_many :reverse_relationships, foreign_key: "followed_id",
            class_name:  "Relationship",
            dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :lessons, dependent: :destroy
  has_many :answers, through: :lessons # learned words用
  has_many :activities, dependent: :destroy
  has_many :categories, through: :lessons
  
  # Follows a user
  def follow(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # Unfollows a user
  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  # the user already has taken the lesson
  def lesson_taken(category_id)
    lesson = lessons.find_by(category_id: category_id)
  end

end
