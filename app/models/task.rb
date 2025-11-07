class Task < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
  
  before_validation :set_default_status
  
  private
  
  def set_default_status
    self.status ||= 'pending'
  end
end

