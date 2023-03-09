class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.float :star, default: 0

      t.timestamps
    end
  end
end
