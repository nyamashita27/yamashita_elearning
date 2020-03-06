class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, allow_nil: true #編集時にPWなくても更新できる
  has_secure_password
  mount_uploader :avatar, AvatarUploader
end
