class Task < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :description, length: { maximum: 10_000 }, allow_blank: true
  
  # Enum for status (replaces the inclusion validation)
  # Hash syntax required to store string values in string column (not integers)
  enum :status, { pending: 'pending', in_progress: 'in_progress', completed: 'completed' }
  
  # Callbacks
  before_validation :set_default_status
  
  # Scopes for query organization
  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :search_by_title, ->(query) { where("LOWER(title) LIKE ?", "%#{query.downcase}%") if query.present? }
  
  # Helper method for badge CSS classes
  def status_badge_class
    case status
    when 'pending' then 'bg-warning text-dark'
    when 'in_progress' then 'bg-info'
    when 'completed' then 'bg-success'
    else 'bg-secondary'
    end
  end

  def status_label
    case status
    when 'pending' then 'Pending'
    when 'in_progress' then 'In Progress'
    when 'completed' then 'Completed'
    else status
    end
  end
  
  private
  
  def set_default_status
    self.status ||= 'pending'
  end
end
