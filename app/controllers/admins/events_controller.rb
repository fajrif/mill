class Admins::EventsController < Admins::BaseController
	before_action :set_event, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Event.all
		else
			criteria = Event.where("title ILIKE ?", "%#{params[:search]}%")
		end

    @events = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params_event)
    if @event.save
			redirect_to admins_event_path(@event), :notice => "Successfully created event."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(params_event)
			redirect_to admins_event_path(@event), :notice  => "Successfully updated event."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to admins_events_url, :notice => "Successfully destroyed event."
  end

	def delete_attachment
		if @asset = ActiveStorage::Attachment.find(params[:asset_id])
			flash[:notice] = "Successfully delete attachment."
			@event.file.purge
		end
		redirect_to admins_event_path(@event)
	end

	def delete_attachment_image
		if @asset = ActiveStorage::Attachment.find(params[:asset_id])
			flash[:notice] = "Successfully delete image."
			@event.image.purge
		end
		redirect_to admins_event_path(@event)
	end

  private

  def params_event
    params.require(:event).permit(:image, :name, :title, :short_description, :content, :published_date, :status, :meta_title, :meta_description)
  end

  def set_event
    @event = Event.friendly.find(params[:id])
  end
end
