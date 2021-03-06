# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new
user.email = "admin@gmail.com"
user.name = "Admin"
user.password = "password123"
user.is_admin = true
user.is_owner = true
user.birthdate = Date.current
user.cellphone = "0900000000"
user.address = "某個地方"
user.gender = "male"
user.national_id = "L1000000000"
user.save!

tags = ["冷凍食品","海外配送","異國風味","全台獨售","安心食材","優惠商品","調味醬料","糕點","特色料理","南北雜貨","早餐朋友","輕鬆煮","養生","暢銷排行","今日即時","年菜專區","零食","限時特價","獨家商品","家傳配方","義式","含蛋料理","韓式","美式","主廚推薦","日式","中式","素食可","蛋奶素","老少咸宜","須冷藏","須冷凍","海鮮","肉品","食材","可微波","焗烤"]

r = Random.new

50.times do |n|
  user = User.new
  user.email = Faker::Internet.unique.email
  user.name = Faker::GameOfThrones.unique.character
  user.is_owner = true
  user.password = "password123"
  user.birthdate = Date.current
  user.cellphone = "09" + Faker::PhoneNumber.subscriber_number(4) + Faker::PhoneNumber.subscriber_number(4)
  user.address = Faker::GameOfThrones.city + Faker::Address.street_address + Faker::Address.secondary_address
  user.national_id = "L1" + Faker::PhoneNumber.subscriber_number(4) + Faker::PhoneNumber.subscriber_number(4) + Faker::PhoneNumber.subscriber_number(1)
  user.save!
end

25.times do |n|
  store = Store.new
  store.name  = Faker::Company.unique.name
  store.address = Faker::GameOfThrones.city + Faker::Address.street_address + Faker::Address.secondary_address
  store.email = Faker::Internet.email
  store.phone = "0" + Faker::PhoneNumber.subscriber_number(4) + Faker::PhoneNumber.subscriber_number(4) + Faker::PhoneNumber.subscriber_number(1)
  store.description = Faker::Hacker.say_something_smart
  store.image = Rails.root.join("app/assets/images/rnd/logo/"+r.rand(1..40).to_s+".gif").open
  store.owner = User.find(r.rand(1..User.count))
  store.user_ids = (1..User.count).to_a.shuffle.take(r.rand(0..10))
  store.user_ids << store.owner.id
  store.user_ids.uniq!
  store.save!
end

250.times do |n|
  item = Item.new
  item.name = Faker::Food.unique.ingredient
  item.store = Store.find(r.rand(1..Store.count))
  item.quantity = r.rand(0..25)
  item.price = r.rand(10..1000)
  item.description = Faker::Hacker.say_something_smart
  item.image = Rails.root.join("app/assets/images/rnd/food/"+r.rand(1..40).to_s+".jpg").open
  num = r.rand(0..8)
  p_tags = (0..tags.count).to_a.shuffle.take(num)
  p_tags.each do |t|
    item.tag_list.add(tags[t])
  end
  item.save!
end
