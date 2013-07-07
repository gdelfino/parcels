require 'spec_helper'

describe Shipment do

  context 'validation of required attributes' do
    let(:shipment){ Shipment.new }

    [:kg, :units3kg, :units5kg].each do |attr|
      it "must have a #{attr}" do
        shipment.should_not be_valid
        shipment.errors[attr].should_not be_empty
      end
    end

  end
  it 'kg should be an integer larger or equal than 8kg'

  it 'factory should be valid' do
    FactoryGirl.build(:shipment).should be_valid
  end
  it 'unit3kg should be a positive integer'
  it 'unit5kg should be a positive integer'
  it 'kg should be equal to 3 * unit3kg + 5 * unit5kg'
  it 'setting kg should automatically set the optimum unit3kg and unit5kg'
  it 'a non optimal combination of kg, unit3kg and unit5kg should be invalid'
end
