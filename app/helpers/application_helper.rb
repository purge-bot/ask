module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def word_declension(amount, words)
    return words[2] if (11..14).include?(amount % 100)

    case amount % 10
    when 1 then words[0]
    when 2..4 then words[1]
    else words[2]
    end
  end
end
