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

end
