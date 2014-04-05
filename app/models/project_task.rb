class ProjectTask # used on Sprint just to keep project + tasks info
  include Mongoid::Document

  embedded_in             :sprint
  belongs_to              :project
  has_and_belongs_to_many :tasks, inverse_of: :nil
end