module ApplicationHelper

  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def word_declension(amount, words)
    return words[2] if (11..14).include?(amount % 100)

    case amount % 10
    when 1 then words[0]
    when 2..4 then words[1]
    else words[2]
    end
  end

  def amount_answered_question
    answer = 0

    @questions.each do |question|
      answer += 1 if !question.answer.nil?
    end
    return answer
  end

  def amount_unanswered_question
    @questions.size - amount_answered_question
  end
end
