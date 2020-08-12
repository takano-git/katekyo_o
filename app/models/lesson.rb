class Lesson < ApplicationRecord
  belongs_to :user

  validate :finish_is_invalid_without_a_start
  validate :start_is_invalid_without_a_finish
  validate :finish_is_invalid_oler_than_start

  # レッスンの終わりの時間が存在しない場合は、始まりの時間は無効
  def finish_is_invalid_without_a_start
    errors.add(:start, "が必要です") if self.start.blank? && self.finish.present?
  end

  # レッスンの始まりの時間が存在しない場合は、終わりの時間は無効
  def start_is_invalid_without_a_finish
    errors.add(:finish, "が必要です") if self.finish.blank? && self.start.present?
  end
  
    # レッスンの終わりの時間が始まりの時間よりはやい場合は無効
  def finish_is_invalid_oler_than_start
    errors.add(:finish, "は開始時間より遅い時間を入力してください") if finish < start
  end
end
