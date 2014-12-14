module ApplicationHelper
	def error_toastr(errors)
		inline = ''
		if errors != nil
			errors.each do |error|
				inline << javascript_tag("toastr.error('#{error[0].capitalize}: #{error[1][0]}')")
			end
		end

		render inline: inline
	end

	def toastr(message, type)
		render inline: javascript_tag("toastr.#{type}('#{message}')")
	end
end
