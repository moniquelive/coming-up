class Star < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates :user, presence: true
  validates :idea, presence: true
end
