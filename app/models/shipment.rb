class Shipment < ActiveRecord::Base
  attr_accessible :kg, :units3kg, :units5kg

  validates :kg, :units3kg, :units5kg, presence: true
  validates :units3kg, :units5kg, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :kg,                  numericality: {greater_than_or_equal_to: 8, only_integer: true}

  validate :kg_units3kg_and_units5kg_are_consistent,
           :kg_units3kg_and_units5kg_are_optimal

  def kg= mass_in_kg
    # This algorithm was deduced with the help of Wolfram Mathematica
    self.units3kg = calc_units3kg(mass_in_kg)
    self.units5kg = calc_units5kg(mass_in_kg)
    super mass_in_kg
  end

  def kg_units3kg_and_units5kg_are_consistent
    return unless kg && units3kg && units5kg
    if kg != 3 * units3kg + 5 * units5kg
      errors.add(:base, "inconsistent kg, units3kg & units5kg")
    end
  end

  def kg_units3kg_and_units5kg_are_optimal
    return unless kg && units3kg && units5kg
    if units3kg != calc_units3kg(kg)
      errors.add(:base, "non-optimal units3kg & units5kg combination")
    end
  end

  private

  def calc_units3kg(mass_in_kg)
    (2 * mass_in_kg - 10) % 5
  end

  def calc_units5kg(mass_in_kg)
    ([-3,-9,0,-6,-12].rotate(mass_in_kg - 8)[0] + mass_in_kg)/5
  end

end
