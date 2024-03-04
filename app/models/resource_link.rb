class ResourceLink < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :link, presence: true
end
