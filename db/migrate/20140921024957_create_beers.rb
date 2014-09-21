class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name, null: false
      t.integer :brewer_id, null: false
      t.float :abv
      t.integer :style_id
      t.integer :beer_id, null: false
      # t.float :cached_rating, null: false

      t.timestamps
    end
  end
end
