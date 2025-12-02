class HomeController < ApplicationController

  def index
		# get public home
		@products = Product.all
		@projetcs = Project.all
		@articles = Article.first(2)
  end

  def about
		# get public about
		@features = Feature.all
  end

end
