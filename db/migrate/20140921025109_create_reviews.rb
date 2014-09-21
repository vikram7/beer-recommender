class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :beer_id, null: false
      t.float :taste, null: false
      t.text :text
      t.float :appearance
      t.float :aroma
      t.float :palate
      t.float :overall

      t.timestamps
    end
  end
end
