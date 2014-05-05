module MoviesHelper
  def is_voted_for?(votable)
    return "<span class='label label-info'><i class='icon-thumbs-up' class='gray_thumb'></i> Like</span>".html_safe if current_user.blank?
    return "<span class='label label-success'><i class='icon-thumbs-up'></i> Liked</span>".html_safe if current_user.voted_for?(votable)
    "<span class='label label-info'><i class='icon-thumbs-up'></i> Like</span>".html_safe
  end

  def is_voted_against?(votable)
    return "<span class='label label-warning'><i class='icon-thumbs-down'></i> Dislike</span>".html_safe if current_user.blank?
    return "<span class='label label-important'><i class='icon-thumbs-down'></i> Disliked</span>".html_safe if current_user.voted_against?(votable)
    "<span class='label label-warning'><i class='icon-thumbs-down'></i> Dislike</span>".html_safe
  end
end
