class Admins::ContactsController < Admins::BaseController

  def index
    criteria = Contact.where("name ILIKE ? OR email ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    @contacts = criteria.page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
      format.js
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to admins_contacts_url, :notice => "Successfully delete contact inquiry."
  end

end
