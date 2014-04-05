class OpenTask
  include Mongoid::Document
  extend NotSti::Task

  embedded_in :project
end