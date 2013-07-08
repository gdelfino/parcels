class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.all
  end

  def show
    @shipment = Shipment.find params[:id]
  end

  def new
    @shipment = Shipment.new
  end

  def create
    @shipment = Shipment.new params[:shipment]
    if @shipment.save
      redirect_to @shipment, notice: 'Shipment was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @shipment = Shipment.find params[:id]
    @shipment.destroy
    redirect_to shipments_url
  end
end
