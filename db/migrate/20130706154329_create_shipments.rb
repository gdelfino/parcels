class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :kg
      t.integer :units3kg
      t.integer :units5kg

      t.timestamps
    end
  end
end
