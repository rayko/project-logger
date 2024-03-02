class Entry < ApplicationRecord
  include Statuses

  belongs_to :project

  validates :project, presence: true
  validates :date, presence: true


  after_commit :update_project_status

  private

  def update_project_status
    project.refresh_status_from_entries!
  end

end
