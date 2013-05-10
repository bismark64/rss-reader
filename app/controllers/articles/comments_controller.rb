class Articles::CommentsController < ApplicationController
  # GET /comments/new
  # GET /comments/new.json
  def new
    @user = current_user
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    @comment = Comment.new(user_id: params[:user_id], article_id: params[:article_id])

    respond_to do |format|
      format.html{ render 'articles/comments/new',:layout => false}
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @user = current_user
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html{ render :partial => 'articles/comments/comment', :locals => {:comment => @comment},:layout => false }
      else
        format.html { render :text => 'There was an error when posting your comment, please try again later' }
      end
    end
  end
end
