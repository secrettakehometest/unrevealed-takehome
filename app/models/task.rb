class Task < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
  
  # Callbacks
  before_validation :set_default_status
  
  # Scopes for query organization
  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :search_by_title, ->(query) { where("LOWER(title) LIKE ?", "%#{query.downcase}%") if query.present? }
  
  private
  
  def set_default_status
    self.status ||= 'pending'
  end
end

