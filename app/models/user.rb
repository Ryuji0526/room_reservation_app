class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :rooms, dependent: :destroy
  has_one_attached :image
  before_save { email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255}, format: {with: VALID_EMAIL_REGEX}, 
                  uniqueness: true
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validates :description, length: {maximum: 300}
  validates :image, content_type: {in: %w[image/jpeg image/gif image/png],
                            message: "はjpeg, gif, pngのいずれかのフォーマットを選択できます。"},
              size: {less_than: 5.megabytes, message: "のファイルサイズは5MB以下にしてください。"}

  has_secure_password

  class << self
  # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Room.where("user_id = ?", id)
  end

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
