class Admins::FeaturesController < Admins::BaseController
	before_action :set_feature, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Feature.all
		else
			criteria = Feature.where("name ILIKE ?", "%#{params[:search]}%")
		end

    @features = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @features }
      format.js
    end
  end

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(params_feature)
    if @feature.save
			redirect_to admins_feature_path(@feature.id), :notice => "Successfully created feature."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @feature.update(params_feature)
			redirect_to admins_feature_path(@feature.id), :notice  => "Successfully updated feature."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @feature.destroy
    redirect_to admins_features_url, :notice => "Successfully destroyed feature."
  end

  private

  def params_feature
    params.require(:feature).permit(:image, :name, :short_description, :description, :caption)
  end

  def set_feature
		@feature = Feature.find(params[:id])
  end
end
