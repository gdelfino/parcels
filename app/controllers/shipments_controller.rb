class ShipmentsController < ApplicationController
  def index
    @shipment = Shipment.new
    @shipments = Shipment.all
  end

  def create
    @shipment = Shipment.new params[:shipment]
    if @shipment.save
      redirect_to shipments_url, notice: 'Shipment was successfully created.'
    else
      @shipments = Shipment.all
      render action: 'index'
    end
  end

  def destroy
    @shipment = Shipment.find params[:id]
    @shipment.destroy
    redirect_to shipments_url
  end
end
