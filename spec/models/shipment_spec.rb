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

  it 'kg should be an integer larger or equal than 8kg' do
    s = Shipment.new
    s.kg = 7
    s.should_not be_valid

    s.kg = 8.5
    s.should_not be_valid
    s.errors[:kg].should_not be_empty

    s.kg = 8
    s.should be_valid
  end

  it 'factory should be valid' do
    FactoryGirl.build(:shipment).should be_valid
  end

  it 'unit3kg and unit5kg should be integers' do
    FactoryGirl.build(:shipment, kg:10, units3kg:1.5, units5kg:1.1).should_not be_valid
  end

  it "automatically sets a value for units3kg and units5kg when you assign a value to kg" do
    s = Shipment.new
    s.units3kg.should be_nil
    s.units5kg.should be_nil
    s.kg = 8
    s.units3kg.should_not be_nil
    s.units5kg.should_not be_nil
  end

  context 'kg should be equal to the optimal combination of 3 and 5 kg units' do
    [[ 8, 1,1], [ 9, 0,3], [ 10, 2,0], [11, 1,2], [12, 0,4], [13, 2,1], [14, 1,3], [15, 3,0], [16, 2,2], [17, 1,4],
     [18, 3,1], [19, 2,3], [ 20, 4,0], [21, 3,2], [22, 2,4], [23, 4,1], [24, 3,3], [25, 5,0], [26, 4,2], [27, 3,4],
     [28, 5,1], [29, 4,3], [ 30, 6,0], [31, 5,2], [32, 4,4], [33, 6,1], [34, 5,3], [35, 7,0], [36, 6,2], [37, 5,4],
     [38, 7,1], [39, 6,3], [ 40, 8,0], [41, 7,2], [42, 6,4], [43, 8,1], [44, 7,3], [45, 9,0], [46, 8,2], [47, 7,4],
     [48, 9,1], [49, 8,3], [ 50,10,0], [51, 9,2], [52, 8,4], [53,10,1], [54, 9,3], [55,11,0], [56,10,2], [57, 9,4],
     [58,11,1], [59,10,3], [ 60,12,0], [61,11,2], [62,10,4], [63,12,1], [64,11,3], [65,13,0], [66,12,2], [67,11,4],
     [68,13,1], [69,12,3], [ 70,14,0], [71,13,2], [72,12,4], [73,14,1], [74,13,3], [75,15,0], [76,14,2], [77,13,4],
     [78,15,1], [79,14,3], [ 80,16,0], [81,15,2], [82,14,4], [83,16,1], [84,15,3], [85,17,0], [86,16,2], [87,15,4],
     [88,17,1], [89,16,3], [ 90,18,0], [91,17,2], [92,16,4], [93,18,1], [94,17,3], [95,19,0], [96,18,2], [97,17,4],
     [98,19,1], [99,18,3], [100,20,0]].each do |kg,u5,u3|
       it "sets units3kg to #{u3} and units5kg to #{u5} when kg=#{kg}" do
         s = Shipment.new
         s.kg = kg
         s.units3kg.should == u3
         s.units5kg.should == u5
         s.should be_valid
       end
     end
  end

  it 'units3kg should be a positive integer' do
    s = FactoryGirl.build :shipment, units3kg: -1
    s.should_not be_valid
    s.errors[:units3kg].should_not be_empty
  end

  it 'units5kg should be a positive integer' do
    s = FactoryGirl.build :shipment, units5kg: -1
    s.should_not be_valid
    s.errors[:units5kg].should_not be_empty
  end

  8.upto(100) do |kilograms|
    it 'kg should be equal to 3 * units3kg + 5 * units5kg' do
      s = Shipment.new(kg: kilograms)
      s.kg.should == 3 * s.units3kg + 5 * s.units5kg
    end
  end

  it 'a non optimal combination of kg, unit3kg and unit5kg should be invalid'
end
