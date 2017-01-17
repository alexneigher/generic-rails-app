# Create 100 random products
100.times do

  # Name is generated with a random adjective and noun.
  # Lists are maintained in /lib/dictionaries/
  name         = "#{choose("adjectives").chomp} #{choose("nouns").chomp}".titleize

  # Random list of manufacturers. Feel free to modify.
  manufacturer = ["AMD", "Apple", "Google", "IBM", "Intel", "Microsoft", "Oracle", "Samsung"].sample

  # Randomize price and quantity.
  # Must be float, float and integer types, respectively.
  price        = (1 + rand(100) + rand()).round(2)
  rating       = (rand(5) + rand()).round(2)
  quantity     = 1 + rand(1000)

  # 10% should be marked as featured
  featured = (rand(100) <= 10)

  # Each product can have a random image. This is default_product.gif by default.
  # Add images to /app/assets/images/
  image        = Dir["app/assets/images/*"].sample.gsub!(/(images\/|app)/, '')

  # Create the product in the database.
  Product.create!(
    name: name,
    price: price,
    rating: rating,
    quantity: quantity,
    image: image,
    manufacturer: manufacturer,
    featured: featured
  )

end

def choose(file)
  File.foreach("lib/dictionaries/#{file}.txt").
       each_with_index.reduce(nil) { |q,r|
         rand < 1.0/(1+r[1]) ? r[0] : q
       }
end
