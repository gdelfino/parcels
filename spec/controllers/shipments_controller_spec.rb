require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ShipmentsController do

  # This should return the minimal set of attributes required to create a valid
  # Shipment. As you add validations to Shipment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:shipment) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ShipmentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all shipments as @shipments" do
      shipment = Shipment.create! valid_attributes
      get :index, {}, valid_session
      assigns(:shipments).should eq([shipment])
    end
  end

  describe "GET show" do
    it "assigns the requested shipment as @shipment" do
      shipment = Shipment.create! valid_attributes
      get :show, {:id => shipment.to_param}, valid_session
      assigns(:shipment).should eq(shipment)
    end
  end

  describe "GET new" do
    it "assigns a new shipment as @shipment" do
      get :new, {}, valid_session
      assigns(:shipment).should be_a_new(Shipment)
    end
  end

  describe "GET edit" do
    it "assigns the requested shipment as @shipment" do
      shipment = Shipment.create! valid_attributes
      get :edit, {:id => shipment.to_param}, valid_session
      assigns(:shipment).should eq(shipment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Shipment" do
        expect {
          post :create, {:shipment => valid_attributes}, valid_session
        }.to change(Shipment, :count).by(1)
      end

      it "assigns a newly created shipment as @shipment" do
        post :create, {:shipment => valid_attributes}, valid_session
        assigns(:shipment).should be_a(Shipment)
        assigns(:shipment).should be_persisted
      end

      it "redirects to the created shipment" do
        post :create, {:shipment => valid_attributes}, valid_session
        response.should redirect_to(Shipment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipment as @shipment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        post :create, {:shipment => { "kg" => "invalid value" }}, valid_session
        assigns(:shipment).should be_a_new(Shipment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        post :create, {:shipment => { "kg" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested shipment" do
        shipment = Shipment.create! valid_attributes
        # Assuming there are no other shipments in the database, this
        # specifies that the Shipment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Shipment.any_instance.should_receive(:update_attributes).with({ "kg" => "1" })
        put :update, {:id => shipment.to_param, :shipment => { "kg" => "1" }}, valid_session
      end

      it "assigns the requested shipment as @shipment" do
        shipment = Shipment.create! valid_attributes
        put :update, {:id => shipment.to_param, :shipment => valid_attributes}, valid_session
        assigns(:shipment).should eq(shipment)
      end

      it "redirects to the shipment" do
        shipment = Shipment.create! valid_attributes
        put :update, {:id => shipment.to_param, :shipment => valid_attributes}, valid_session
        response.should redirect_to(shipment)
      end
    end

    describe "with invalid params" do
      it "assigns the shipment as @shipment" do
        shipment = Shipment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        put :update, {:id => shipment.to_param, :shipment => { "kg" => "invalid value" }}, valid_session
        assigns(:shipment).should eq(shipment)
      end

      it "re-renders the 'edit' template" do
        shipment = Shipment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Shipment.any_instance.stub(:save).and_return(false)
        put :update, {:id => shipment.to_param, :shipment => { "kg" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested shipment" do
      shipment = Shipment.create! valid_attributes
      expect {
        delete :destroy, {:id => shipment.to_param}, valid_session
      }.to change(Shipment, :count).by(-1)
    end

    it "redirects to the shipments list" do
      shipment = Shipment.create! valid_attributes
      delete :destroy, {:id => shipment.to_param}, valid_session
      response.should redirect_to(shipments_url)
    end
  end

end
