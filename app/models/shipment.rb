class Shipment < ActiveRecord::Base
  attr_accessible :kg, :units3kg, :units5kg
  validates :kg, :units3kg, :units5kg, presence: true
  validates :units3kg, :units5kg, numericality: {only_integer: true}

  def kg= val
    self.units3kg = 1
    self.units5kg = 1
    super val
  end

end
