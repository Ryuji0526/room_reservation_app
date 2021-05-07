class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 200}
  validates :fee, numericality: {only_integer: true}
  validates :address, presence: true
  validates :image, content_type: {in: %w[image/jpeg image/gif image/png],
                message: "jpeg, gif, pngのいずれかのフォーマットを選択してください"},
              size: {less_than: 5.megabytes, message: "ファイルサイズは5MB以下にしてください。"}

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def get_reservations_info(user)
    Reservation.where('user_id = ? and room_id = ?',user.id, id).first
  end

end
