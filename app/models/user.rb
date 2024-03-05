class User < ApplicationRecord
  has_secure_password validations: true

  has_many :projects

  validates :email, presence: true, uniqueness: true

  attr_accessor :old_password, :new_password, :new_password_confirmation

  def update_password
    unless authenticate(old_password)
      errors.add :old_password, 'is invalid'
    end

    if new_password_confirmation.blank?
      errors.add :new_password_confirmation, 'does not match'
    end
    
    unless new_password == new_password_confirmation
      errors.add :new_password_confirmation, 'does not match'
    end

    return false if errors.any?

    update(password: new_password)
  end
end
