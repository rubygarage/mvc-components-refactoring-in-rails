class ProjectsController < ApplicationController
  def create
    if policy.allowed?
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

  def policy
    CreateProjectPolicy.new(current_user, redis)
  end

  def redis
    Redis.current
  end
end