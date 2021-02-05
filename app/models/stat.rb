class Stat < ApplicationRecord
  has_many :sprayers
  accepts_nested_attributes_for :sprayers
end
