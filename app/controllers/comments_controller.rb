class CommentsController < ApplicationController
  def new
    @article = Article.find(params[:article_id])
    @article_comment = @article.comments.new
  end

  def create
    @article = Article.find(params[:article_id])
    @article_comment = @article.comments.new(comment_params)
    @article_comment.user_id = current_user.id
    if @article_comment.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
