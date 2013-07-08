require 'spec_helper'

describe ShipmentsController do

  let(:valid_attributes) { FactoryGirl.attributes_for(:shipment) }

  describe 'GET index' do
    it 'assigns all shipments as @shipments' do
      shipment = Shipment.create! valid_attributes
      get :index
      assigns(:shipments).should eq([shipment])
    end
    it 'assigns a new shipment as @shipment' do
      get :index
      assigns(:shipment).should be_a_new(Shipment)
    end

  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Shipment' do
        expect {
          post :create, shipment: valid_attributes
        }.to change(Shipment, :count).by(1)
      end

      it 'assigns a newly created shipment as @shipment' do
        post :create, shipment: valid_attributes
        assigns(:shipment).should be_a(Shipment)
        assigns(:shipment).should be_persisted
      end

      it 'redirects to the created shipment' do
        post :create, shipment: valid_attributes
        response.should redirect_to(shipments_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipment as @shipment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        post :create, shipment: { 'kg' => 'invalid value' }
        assigns(:shipment).should be_a_new(Shipment)
      end

      it "re-renders the 'index' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        post :create, shipment: { 'kg' => 'invalid value' }
        response.should render_template('index')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested shipment' do
      shipment = Shipment.create! valid_attributes
      expect {
        delete :destroy, id: shipment.to_param
      }.to change(Shipment, :count).by(-1)
    end

    it 'redirects to the shipments list' do
      shipment = Shipment.create! valid_attributes
      delete :destroy, id: shipment.to_param
      response.should redirect_to(shipments_url)
    end
  end

end
