class Articles::ArticlesController < ApplicationController
  def star
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    
    if @article.star_article
      respond_to do |format|
        format.html{ render :partial => 'star', :locals => {:article => @article}, :layout => false}
      end
    end
  end

  def starred
    @user = User.find(params[:user_id])
    @articles = Article.starred.order('"pubDate" DESC')
  end  
end