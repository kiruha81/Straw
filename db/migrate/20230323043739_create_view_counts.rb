class CreateViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :view_counts do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
