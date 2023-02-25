# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



if Rails.env == "development"
	levels = ["Beginner", "Intermediate", "Advanced"]
	fake_users = [
		{:fname => "Jennifer", :lname => "Pereira", weight: 100, :height => 64, email: 'jen.mp12@gmail.com', level: levels.sample, goal: 'Get better'},
		{:fname => "Zack", :lname => "Carter", weight: 190, :height => 71, email: 'zackcarter@gmail.com', level: levels.sample, goal: 'Get better'},
		{:fname => "Jeff", :lname => "Judge", weight: 230, :height => 73, email: 'jen.mp12@gmail.com', level: levels.sample, goal: 'Get better'}
	]

	fake_users.each do |u|
		u[:password] = 'secret'
		already_existed = User.find_by(email: u[:email])
		unless already_existed
			User.create(u)
		end
	end
	print("Completed")
end
