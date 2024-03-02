class Project < ApplicationRecord
  include Statuses

  has_many :entries

  scope :open, -> { where(status: [:pending, :booting, :ongoing, :paused, :blocked]) }
  scope :closed, -> { where(status: [:finished, :closed, :abandonded]) }

  validates :name, presence: true
  validates :description, presence: true

  def set_locked
    locked = true
    locked_at = Time.now
  end

  def set_locked!
    set_locked
    save
  end

end
