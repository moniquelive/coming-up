class Idea < ApplicationRecord
  belongs_to :user
  has_many :stars

  validates :user, presence: true

  after_create :add_star_from_user

  private

  def add_star_from_user
    Star.create! user: self.user, idea: self
  end
end
