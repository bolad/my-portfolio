3.times do |topic|
  Topic.create!(
    title: "Topic #{topic}"
  )
end

User.create!(name: 'Stanley',
             email: 'stanley@example.com',
             password: 'password'
)

10.times do |_i|
  User.create!(name: Faker::Name.unique.first_name,
               email: Faker::Internet.unique.email,
               password: 'password'
  )
end

pseudo_rng = Random.new

25.times do |i|
  blog = Blog.new
  blog.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
  blog.body = Faker::Lorem.paragraph_by_chars(number: 1500)
  blog.views = Faker::Number.between(from: 1, to: 500)
  blog.topic_id = Topic.last.id
  blog.save

  (2 + pseudo_rng.rand(8)).times do |_j|
    comment = blog.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500),
                                  user: User.find(2 + pseudo_rng.rand(10)))
    comment.save
    pseudo_rng.rand(5).times do |_k|
      nested_comment = comment.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500),
                                              user: User.find(2 + pseudo_rng.rand(1)),
                                              reply: true)
      nested_comment.save
    end
  end
end
