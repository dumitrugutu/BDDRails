module ArticlesHelper
  def persited_comments(comments)
    comments.reject { |comment| comment.new_record? }
  end
end
