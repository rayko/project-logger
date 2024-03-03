class TodoItem < ApplicationRecord
  belongs_to :project

  validates :text, presence: true
  validates :project, presence: true

  def flip!
    return check! if !checked?
    return uncheck! if checked?
  end

  def check!
    update_attribute :checked, true
  end

  def uncheck!
    update_attribute :checked, false
  end

end
