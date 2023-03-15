# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'admin@admin.com',
    password: 'admin999',
  )

Genre.create!(
  [
    { name: 'レストラン' },
    { name: 'カフェ' },
    { name: '和食屋' },
    { name: 'ラーメン' },
    { name: 'うどん' },
    { name: 'そば' },
    { name: '焼肉' },
    { name: '寿司' },
    { name: '本屋' },
    { name: '家電量販店' },
    { name: 'ガソリンスタンド' },
    { name: '自動車' },
    { name: 'ゲームセンター' },
    { name: 'カラオケ' },
    { name: 'ショッピングモール' },
    { name: '病院' },
    { name: '美容院' },
    { name: '歯医者' },
    { name: 'スーパー' },
    { name: 'コンビニ' },
    { name: 'ホームセンター' },
    { name: 'ドラッグストア' },
    { name: '道の駅' },
    { name: '八百屋' },
    { name: '鮮魚' },
    { name: '精肉' },
    { name: '和菓子' },
    { name: '洋菓子' },
    { name: '温泉' },
    { name: '銭湯' },
    { name: '焼肉' },
    { name: '公園' },
  ]
)

Customer.create!(
  name: 'ほげ',
  gender: 0,
  prefecture: 0,
  is_deleted: false,
  email: 'hogehoge@hoge.com',
  password: 'hogehoge',
)

#customer = Customer.new(:name => "ほげ", :gender => 0, :prefecture => 0, :email => "hogehoge@hoge.com", :password => "hugahuga", :is_deleted => false)
#customer.save!
#
#customer2 = Customer.new(:name => "ほげ2", :gender => 0, :prefecture => 0, :email => "hogehoge2@hoge.com", :password => "hugahuga", :is_deleted => false)
#customer2.save!