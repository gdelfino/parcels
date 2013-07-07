class Shipment < ActiveRecord::Base
  attr_accessible :kg, :units3kg, :units5kg
  validates :kg, :units3kg, :units5kg, presence: true
  validates :units3kg, :units5kg, numericality: {only_integer: true}
end
