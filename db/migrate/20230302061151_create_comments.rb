class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :title, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
