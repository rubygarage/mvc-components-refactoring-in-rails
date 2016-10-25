class ProjectsController < ApplicationController
  def create
    if can_create_project?
      @project = Project.create!(project_params)
      render json: @project, status: :created
    else
      head :unauthorized
    end
  end

  private

  def can_create_project?
    current_user.manager? &&
      current_user.projects.count < Project.max_count &&
      redis.get('projects_creation_blocked') != '1'
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def redis
    Redis.current
  end
end