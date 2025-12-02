class Admins::DashboardController < Admins::BaseController

  def index
    @total_articles = Article.count
    @total_contacts = Contact.count
  end

end
