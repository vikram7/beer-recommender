class CreateBrewers < ActiveRecord::Migration
  def change
    create_table :brewers do |t|
      t.string :name
      t.string :location
      t.integer :brewer_id

      t.timestamps
    end
  end
end
