class Shipment < ActiveRecord::Base
  attr_accessible :kg, :units3kg, :units5kg
  validates :kg, :units3kg, :units5kg, presence: true
  validates :units3kg, :units5kg, numericality: {only_integer: true}
  validates :kg, numericality: {greater_than_or_equal_to: 8, only_integer: true}

  def kg= val
    # This algorithm was deduced with the help of Wolfram Mathematica
    self.units3kg = (2 * val - 10) % 5
    self.units5kg = ([-3,-9,0,-6,-12].rotate(val-8)[0] + val)/5
    super val
  end

end
