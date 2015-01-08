

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)
20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
=begin
Category.create!(name: "Toys")
Category.create!(name: "Beauty, Health & Grocery")
Category.create!(name: "Movies, Music & Games")
Category.create!(name: "Home, Garden & Tools")
Category.create!(name: "Clothing, Shoes & Jewelry")
Category.create!(name: "Kindle E-readers & Books")
Category.create!(name: "Books & Audible")
=end
 Category.create!(name: "Toys")
Category.create!(name: "Tools")
Category.create!(name: "MobileApps")
Category.create!(name: "Electronics")
Category.create!(name: "Jewelry")
Category.create!(name: "Shoes")
Category.create!(name: "Beauty")
Category.create!(name: "Baby")
Category.create!(name: "Books")


cats = Category.all     

request = Vacuum.new('GB')
request.configure(
  aws_access_key_id: 'AKIAIPI5O5WRCJKUVADQ',
  aws_secret_access_key: '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',
  associate_tag: 'tags'
  )

 Keywords = {
   :Toys => :toy,
   :Tools => :bag,
   :MobileApps => :iphone,
   :Electronics => :computer,
   :Jewelry => :ring,
   :Shoes => :shoe,
   :Beauty => :soap,   
   :Baby => :baby,
   :Books => :book,
 }

2.times do |i|
  cats.each do |cat|
    puts cat.name + "------------" + Keywords[cat.name.to_sym][i].to_s
    params = {
      'SearchIndex' => cat.name,
      'Keywords'=> Keywords[cat.name.to_sym][i],
      'ResponseGroup' => "ItemAttributes,Images",
      'Operation' => 'ItemSearch'
    }

    raw_products = request.item_search(query: params)
    hashed_products = raw_products.to_h
    
    if !hashed_products['ItemSearchResponse']['Items']['Item'].nil?
      if hashed_products['ItemSearchResponse']['Items']['Item'].any?
        hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
          product = Product.new
          product.name = item['ItemAttributes']['Title'].length > 100 ? item['ItemAttributes']['Title'][0..100]: item['ItemAttributes']['Title']
          # product.url = item['DetailPageURL']

          product.urlImage = item['SmallImage']['URL'] unless item['SmallImage'].nil?
          product.urlLargeImage = item['LargeImage']['URL'] unless item['LargeImage'].nil?

          if !item['ItemAttributes']['ListPrice'].nil?
            product.price = item['ItemAttributes']['ListPrice']['FormattedPrice']         
          else 
            product.price="$0.0"
          end
          if !item['ItemAttributes']['Feature'].nil?
            product.description = item['ItemAttributes']['Feature']
          else 
            product.description="description text"
          end

          product.category_id = cat.id
          product.user_id = "1"

          product.save
          
        end
      end
    end
  end
end
