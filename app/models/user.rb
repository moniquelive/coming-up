class User < ApplicationRecord
  has_many :ideas
  has_many :stars
end
