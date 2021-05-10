class Reservation < ApplicationRecord
  require "date"
  belongs_to :user
  belongs_to :room
  default_scope -> {order(:start_date)}

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_people, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate :date_before_start
  validate :end_date_should_be_after_start_date

  def date_before_start
    errors.add(:start_date, "は今日以降の日付を選択してください") if !(start_date.nil?) && start_date < Date.today
  end

  def end_date_should_be_after_start_date
    errors.add(:end_date, "は開始日より後の日付を選択してください") if !(start_date.nil?) && !(end_date.nil?) && start_date >= end_date
  end
end
