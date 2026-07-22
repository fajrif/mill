class HomeController < ApplicationController

  def index
		# get public home
		@products = Product.all
		@projects = Project.published
		@articles = Article.first(2)
  end

  def about
		# get public about
		@features = Feature.all
  end

end
