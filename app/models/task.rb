class Task < ApplicationRecord
  enum :status, { todo: 0, doing: 1, done: 2 }, default: :todo

  validates :title, presence: true, length: { maximum: 100 }

  scope :overdue, -> { where.not(status: :done).where(due_on: ...Date.current) }
end
