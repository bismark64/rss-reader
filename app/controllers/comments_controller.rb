class CommentsController < ApplicationController
  # GET /comments/new
  # GET /comments/new.json
  def new
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    @comment = Comment.new(user_id: params[:user_id], article_id: params[:article_id])

    respond_to do |format|
      format.html{ render :layout => false}
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @user = User.find(params[:user_id])
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html{ render :partial => 'comment', :locals => {:comment => @comment},:layout => false }
      else
        format.html { render action: "new" }
      end
    end
  end
end
