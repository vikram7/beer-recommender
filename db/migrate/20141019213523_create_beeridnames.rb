class CreateBeeridnames < ActiveRecord::Migration
  def change
    create_table :beeridnames do |t|
      t.json :payload

      t.timestamps
    end
  end
end
