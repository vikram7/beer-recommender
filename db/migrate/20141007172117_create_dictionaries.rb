class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.json :payload

      t.timestamps
    end
  end
end
