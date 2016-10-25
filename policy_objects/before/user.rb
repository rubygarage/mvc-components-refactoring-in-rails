def User < ActiveRecord::Base
  enum role: [:manager, :employee, :guest]
end