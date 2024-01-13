# Add this to your Gemfile
# gem 'faker'


require 'faker'


10.times do
  user = User.create(name: Faker::Name.name, ip_address: Faker::Internet.ip_v4_address)

  1000.times do
    title = Faker::Lorem.sentence(word_count: 5)
    body = Faker::Lorem.sentence(word_count: 20)

    Article.create(title: title, body: body)
  end
end
