class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :plant_symbol
      t.string :syn_symbol
      t.string :sci_name
      t.string :common_name
      t.string :plant_family

      t.timestamps
    end
  end
end
