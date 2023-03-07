module ApplicationHelper

	def navigation_setter
		"#{action_name}_#{controller_name}"
	end
end
