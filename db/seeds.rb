10.times do |_i|
  User.create!(
               name: Faker::Name.unique.first_name,
               email: Faker::Internet.unique.email,
               password: 'password'
             )
end



25.times do |i|
    blog = Blog.new
    blog.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
    blog.body = Faker::Lorem.paragraph_by_chars(number: 1500)
    blog.save
end
