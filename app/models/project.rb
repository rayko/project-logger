class Project < ApplicationRecord
  include Statuses

  has_rich_text :description
  has_many_attached :file_assets
  
  has_many :entries
  has_many :todo_items
  has_many :resource_links
  belongs_to :user

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

  def refresh_status_from_entries!
    return status if entries.empty?

    last_entry = entries.order('date DESC').first
    return status if last_entry.status == status

    update_attribute :status, last_entry.status
    status
  end
  
end
