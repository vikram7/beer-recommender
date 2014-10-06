class AddIndicesToForeignKeys < ActiveRecord::Migration
  def change
    add_index :beers, :brewer_id
    add_index :beers, :style_id
    add_index :reviews, :user_id
    add_index :reviews, :beer_id
  end
end
