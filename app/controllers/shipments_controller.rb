class ShipmentsController < ApplicationController
  def index
    @shipment = Shipment.new
    @shipments = Shipment.all
  end

  def create
    @shipment = Shipment.new params[:shipment]
    respond_to do |format|
      if @shipment.save
        format.html { redirect_to shipments_url, notice: 'Shipment was successfully created.' }
        format.js
      else
        @shipments = Shipment.all
        format.html { render action: 'index' }
        format.js
      end
    end
  end

  def destroy
    @shipment = Shipment.find params[:id]
    @shipment.destroy
    redirect_to shipments_url
  end
end
