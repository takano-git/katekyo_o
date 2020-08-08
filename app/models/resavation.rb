class Resavation < ApplicationRecord
  belongs_to :user

  validate :end_is_invalid_without_a_start
  validate :start_is_invalid_without_a_end
  validate :end_is_invalid_oler_than_start

  # Resavationの終わりの時間が存在しない場合は、始まりの時間は無効
  def end_is_invalid_without_a_start
    errors.add(:start, "が必要です") if self.start.blank? && self.end.present?
  end

  # Resavationの始まりの時間が存在しない場合は、終わりの時間は無効
  def start_is_invalid_without_a_end
    errors.add(:end, "が必要です") if self.end.blank? && self.start.present?
  end

    # Resavationの終わりの時間が始まりの時間よりはやい場合は無効
  def end_is_invalid_oler_than_start
    errors.add(:end, "は開始時間より遅い時間を入力してください") if self.end < self.start
  end
end
