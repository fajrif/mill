class Admins::ProjectsController < Admins::BaseController
	before_action :set_project, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Project.all
		else
      criteria = Project.where("full_name ILIKE ?", "%#{params[:search]}%")
		end

    @projects = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
      format.js
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params_project)
    if @project.save
			redirect_to admins_project_path(@project.id), :notice => "Successfully created project."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(params_project)
			redirect_to admins_project_path(@project.id), :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to admins_projects_url, :notice => "Successfully destroyed project."
  end

  private

  def params_project
    params.require(:project).permit(:image, :banner, :name, :short_description, :description, :caption, images: [])
  end

  def set_project
		@project = Project.find(params[:id])
  end
end
