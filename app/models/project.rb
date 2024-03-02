class Project < ApplicationRecord
  # enum :status, [:pending, :booting, :ongoing, :paused, :blocked, :finished, :closed, :abandoned]
  enum :status, { pending: 'pending',
                  booting: 'booting',
                  ongoing: 'ongoing',
                  paused: 'paused',
                  blocked: 'blocked',
                  finished: 'finished',
                  closed: 'closed',
                  abandoned: 'abandoned' }, prefix: true, scopes: true, validate: true, default: :pending

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
