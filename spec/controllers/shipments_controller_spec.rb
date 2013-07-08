require 'spec_helper'

describe ShipmentsController do

  let(:valid_attributes) { FactoryGirl.attributes_for(:shipment) }

  describe 'GET index' do
    it 'assigns all shipments as @shipments' do
      shipment = Shipment.create! valid_attributes
      get :index
      assigns(:shipments).should eq([shipment])
    end
  end

  describe 'GET show' do
    it 'assigns the requested shipment as @shipment' do
      shipment = FactoryGirl.create :shipment
      get :show, id: shipment.to_param
      assigns(:shipment).should eq(shipment)
    end
  end

  describe 'GET new' do
    it 'assigns a new shipment as @shipment' do
      get :new
      assigns(:shipment).should be_a_new(Shipment)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested shipment as @shipment' do
      shipment = FactoryGirl.create :shipment
      get :edit, id: shipment.to_param
      assigns(:shipment).should eq(shipment)
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
        response.should redirect_to(Shipment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipment as @shipment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        post :create, shipment: { 'kg' => 'invalid value' }
        assigns(:shipment).should be_a_new(Shipment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        post :create, shipment: { 'kg' => 'invalid value' }
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested shipment' do
        shipment = Shipment.create! valid_attributes
        # Assuming there are no other shipments in the database, this
        # specifies that the Shipment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Shipment.any_instance.should_receive(:update_attributes).with({ 'kg' => '8' })
        put :update, id: shipment.to_param, shipment: { 'kg' => '8' }
      end

      it 'assigns the requested shipment as @shipment' do
        shipment = Shipment.create! valid_attributes
        put :update, id: shipment.to_param, shipment: valid_attributes
        assigns(:shipment).should eq(shipment)
      end

      it 'redirects to the shipment' do
        shipment = Shipment.create! valid_attributes
        put :update, id: shipment.to_param, shipment: valid_attributes
        response.should redirect_to(shipment)
      end
    end

    describe 'with invalid params' do
      it 'assigns the shipment as @shipment' do
        shipment = Shipment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        put :update, id: shipment.to_param, shipment: { 'kg' => 'invalid value' }
        assigns(:shipment).should eq(shipment)
      end

      it "re-renders the 'edit' template" do
        shipment = Shipment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        put :update, id: shipment.to_param, shipment: { 'kg' => 'invalid value' }
        response.should render_template('edit')
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
