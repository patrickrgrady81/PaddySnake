User.destroy_all

User.create(username: "Anonymous", email:"anon@pat.com", password:"password")
User.create(username: "Pat", email:"pat@pat.com", password:"password")

u = User.find_by(username: "Pat")
puts "User #{u.email} Created!"

# create 10 scores and add them to the user

4.times do 
  # random number between 10 and 100
  r = ((rand * 90) + 10).floor
  s = Score.create(user_id: u.id, value: r)
end

s = Score.create(user_id: u.id, value: 5)

puts "#{u.scores.all.count} Scores Created for #{u.email}"

u.scores.all.order("value DESC").each do |score|
  puts "#{u.email}: #{score.value}"
end