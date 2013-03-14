module ApplicationHelper

	def get_time_difference(time)
		time_diff = Time.now - time

		if time_diff < 60
			print_time time_diff, 'Second'
		elsif time_diff < 60 * 60
			print_time (time_diff / 60), 'Minute'
		elsif time_diff < 60 * 60 * 24
			print_time (time_diff / 60 / 60), 'Hour'
		elsif time_diff < 60 * 60 * 24 * 30
			print_time (time_diff / 60 / 60 / 24), 'Day'
		elsif time_diff < 60 * 60 * 24 * 365
			print_time (time_diff / 60 / 60 / 24 / 30), 'Month'
		else
			print_time (time_diff / 60 / 60 / 24 / 365), 'Year'
		end
	end

	private
	def print_time(amount, type)
		"#{amount.to_i} #{type + ((amount > 1 || amount = 0) ? 's' : '')} Ago"
	end

end
