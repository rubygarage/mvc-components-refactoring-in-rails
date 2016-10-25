class ProjectsController < ApplicationController
  def create
    if current_user.can_create_project?
      @project = Project.create!(project_params)
      render json: @project, status: :created
    else
      head :unauthorized
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end