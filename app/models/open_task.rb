class OpenTask
  include Mongoid::Document
  include Task

  embedded_in :project
end