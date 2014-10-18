class CreateSimilarities < ActiveRecord::Migration
  def change
    create_table :similarities do |t|
      t.json :payload

      t.timestamps
    end
  end
end
