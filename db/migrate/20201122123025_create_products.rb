class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :category
      t.boolean :is_status, default: false
      t.string :email

      t.timestamps
    end
  end
end
