module CalendarHelper

	def day_of_week day_integer
		case day_integer
			when 1
				return "Monday"
			when 2
				return "Tuesday"
			when 3
				return "Wednesday"
			when 4
				return "Thursday"
			when 5
				return "Friday"
			when 6
				return "Saturday"
			when 0
				return "Sunday"
		end
	end
end
