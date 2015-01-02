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

	def format_function(function)
		if (function == "admin")
			return "Administrador"
		elsif (function == "federation")
			return "Federação"
		else
			return "Usuário"
		end
	end

	def messages_alert
		if number_of_messages > 0
			render inline: javascript_tag("toastr.info('','Novas mensagens - #{number_of_messages}')") 
		end
	end
end
