class ClosedTask
  include Mongoid::Document
  include Task

  belongs_to :project
end