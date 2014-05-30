class ProjectSprint
  include Mongoid::Document
  include Sprint
  include TaskWrapper

  embedded_in :project
end