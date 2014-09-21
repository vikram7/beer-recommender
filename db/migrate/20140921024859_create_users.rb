class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :profile_name, null: false

      t.timestamps
    end
  end
end
