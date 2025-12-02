class ProjectsController < ApplicationController

  def index
		criteria = Project.all
    @projects = criteria.page(params[:page]).per(12)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
		@project = Project.friendly.find(params[:id])
		# Other Projects
    @projects = Project.most_recent_projects(@project.id, 2)
  end

end

