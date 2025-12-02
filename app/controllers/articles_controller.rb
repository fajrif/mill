class ArticlesController < ApplicationController

  def index
		criteria = Article.all
    @articles = criteria.page(params[:page]).per(12)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
		@article = Article.friendly.find(params[:id])
		# Other Articles
    @articles = Article.most_recent_articles(@article.id, 2)
  end

end
