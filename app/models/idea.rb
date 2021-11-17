class Idea < ApplicationRecord
  belongs_to :user
  has_many :stars

  validates :user, presence: true

  after_create :add_star_from_owner

  private

  def add_star_from_owner
    Star.create! user: self.user, idea: self
  end
end
