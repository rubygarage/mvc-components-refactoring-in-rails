def User < ActiveRecord::Base
  enum role: [:manager, :employee, :guest]

  def can_create_project?
    manager? &&
      projects.count < Project.max_count &&
        redis.get('projects_creation_blocked') != '1'
  end

  private

  def redis
    Redis.current
  end
end