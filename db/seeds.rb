25.times do |i|
    blog = Blog.new
    blog.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
    blog.body = Faker::Lorem.paragraph_by_chars(number: 1500)
    blog.views = Faker::Number.between(from: 1, to: 5000)
    blog.save
end
