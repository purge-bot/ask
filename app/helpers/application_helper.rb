module ApplicationHelper

	def user_avatar(user)
		if user.avatar_url.present?
			user.avatar_url
		else
			asset_path 'avatar.jpg'
		end
	end

	def amount_questions(questions)
		"Кол-во вопросов: #{questions.size}"
	end
end
