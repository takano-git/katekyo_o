class Lesson < ApplicationRecord
  belongs_to :user

  validate :end_is_invalid_without_a_start
  validate :start_is_invalid_without_a_end

  # レッスンの終わりの時間が存在しない場合は、始まりの時間は無効
  def end_is_invalid_without_a_start
    errors.add(:start, "が必要です") if self.start.blank? && self.end.present?
  end

  # レッスンの始まりの時間が存在しない場合は、終わりの時間は無効
  def start_is_invalid_without_a_end
    errors.add(:end, "が必要です") if self.end.blank? && self.start.present?
  end
end
