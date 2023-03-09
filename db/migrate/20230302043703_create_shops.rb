class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :shop_name, null: false
      t.boolean :is_hidden, null: false, default: false

      t.timestamps
    end
  end
end
