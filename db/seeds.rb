# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  name         = "#{choose("adjectives")} #{choose("nouns")}".titleize
  manufacturer = ["AMD", "Apple", "Google", "IBM", "Intel", "Microsoft", "Samsung"].sample
  price        = (1 + rand(100) + rand()).round(2)
  quantity     = 1 + rand(1000)
  image        = Dir["public/assets/default_product*.gif"].sample.gsub!(/public/, '')

  Product.create!(name: name, price: price, quantity: quantity, image: image, manufacturer: manufacturer)

end

def choose(file)
File.foreach("lib/dictionaries/#{file}.txt").each_with_index.reduce(nil) { |q,r|
  rand < 1.0/(1+r[1]) ? r[0] : q }
end
