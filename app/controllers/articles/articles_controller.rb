class Articles::ArticlesController < ApplicationController
  def all
    @user = current_user
    @articles = @user.articles
  end

  def star
    @user = current_user
    @article = Article.find(params[:article_id])
    
    if @article.star_article
      respond_to do |format|
        format.html{ render :partial => 'star', :locals => {:article => @article}, :layout => false}
      end
    end
  end

  def starred
    @user = current_user
    @articles = current_user.starred_articles
  end  
end