# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts'Deleting old events, demo and eventtypes and comments'

Comment.destroy_all

Event.destroy_all

Demo.destroy_all

EventType.destroy_all

User.destroy_all

puts'starting seeds'


user = User.create!({
    email: Faker::Internet.email(domain: 'gmail'),
    password: Faker::Internet.password(min_length: 10, max_length: 20),

  })

user2 = User.create!({
    email: Faker::Internet.email(domain: 'gmail'),
    password: Faker::Internet.password(min_length: 10, max_length: 20),

  })



demo = Demo.create!(description:'Lorem Ipsum  ', name:'Fridays for future', user: user)

event_type1 = EventType.create!(name: 'sit-in', icon: 'sit-in.svg')
event_type2 = EventType.create!(name: 'speach', icon: 'share.svg')
event_type3 = EventType.create!(name: 'police', icon: 'group.svg')
event_type4 = EventType.create!(name: 'medics', icon: 'logo.png')

event1 = Event.create!(description: 'Super important', location:'Friedrichstraße 2 Berlin', demo: demo, event_type: event_type1, user: user)
event2 = Event.create!(description: 'important', location:'Friedrichstraße 4 Berlin', demo: demo, event_type: event_type2, user: user)
Event.create!(description: 'lets meet', location:'Friedrichstraße 40 Berlin', demo: demo, event_type: event_type3, user: user)
Event.create!(description: 'super meeting', location:'Friedrichstraße 45 Berlin', demo: demo, event_type: event_type4, user: user)

Comment.create!(user: user, content: 'This is a test comment for an Event', commentable: event1)
Comment.create!(user: user, content: 'This is another test comment for the same event', commentable: event1)
Comment.create!(user: user, content: 'This is a test comment for an Event', commentable: event2)
Comment.create!(user: user, content: 'This is a test comment for a demonstration', commentable: demo)
Comment.create!(user: user, content: 'This is another test comment for a demonstration', commentable: demo)
Comment.create!(user: user, content: 'And even a third test comment for a demonstration', commentable: demo)

puts'finished'
