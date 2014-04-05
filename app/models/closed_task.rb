class ClosedTask
  include Mongoid::Document
  extend NotSti::Task

  belongs_to :project
end