class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

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

  def show
  end

  def edit
    @article = @comment.article
    @article_comment = @comment
  end

  def update
    @article = @comment.article
    @article_comment = @comment
    if @article_comment.update(comment_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = @comment.article
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You need to log in to perform that action"
      redirect_to root_path
    end
  end

  def require_same_user
    if current_user.id != @comment.user_id && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own comments"
      redirect_to root_path
    end
  end
end
