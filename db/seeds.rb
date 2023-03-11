# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



if Rails.env == "development"
	weights = (75..300).to_a
	heights = (48..84).to_a
	ratings = 0.1.step(by: 0.1, to: 5).to_a
	levels = ["Beginner", "Intermediate", "Advanced"]
	states = CS.states(:us)
	fake_users = [
		{:fname => "Michael", :lname => "Aronian", :is_user => true,  weight: 175, :height => 69, email: "aronian.m@gmail.com", :level => "Advanced", :goal => "Be better", :city => "Chelmsford", state: 'MA'},
	]

	fake_users.each.with_index do |u,i |
		u[:password] = 'secret'
		already_existed = User.find_by(email: u[:email])
		unless already_existed
			user = User.create(u)
			if i == 0
				user.add_role('admin')
			end
		end
	end

	400.times do
		state = states.keys.sample
		city = CS.cities(state, :us)
		fname = Faker::Name.first_name
		lname = Faker::Name.last_name
		u = {fname: fname, lname: lname, :is_trainor => true, weight: weights.sample, height: heights.sample, email: "#{fname}.#{lname}@gmail.com", level: levels.sample, goal: Faker::Quote.jack_handey, city: city.sample, state: state, rating: ratings.sample.round(1)}
		u[:password] = 'secret'
		already_existed = User.find_by(email: u[:email])
		unless already_existed
			user = User.create(u)
		end
	end

	400.times do 
		state = states.keys.sample
		city = CS.cities(state, :us)
		fname = Faker::Name.first_name
		lname = Faker::Name.last_name
		u = {fname: fname, lname: lname, weight: weights.sample, :is_user => true, height: heights.sample, email: "#{fname}.#{lname}@gmail.com", level: levels.sample, goal: Faker::Quote.jack_handey, city: city.sample, state: state, rating: ratings.sample.round(1)}
		u[:password] = 'secret'
		already_existed = User.find_by(email: u[:email])
		unless already_existed
			user = User.create(u)
		end
	end
	print("Completed")
end
