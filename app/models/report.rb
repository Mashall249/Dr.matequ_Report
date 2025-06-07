class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  enum reason: {
    spam: 0,
    abuse: 1,
    harassment: 2,
    inappropriate_content: 3,
    illegal_content: 4,
    other: 5
  }

  enum status: { unreviewed: 'unreviewed', reviewed: 'reviewed', resolved: 'resolved' }

  validates :reason, presence: true
end
