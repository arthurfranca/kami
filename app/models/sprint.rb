class Sprint # can be a project sprint or a company sprint (that can include more than one project's tasks)
  include Mongoid::Document

  embedded_in :sprintish, polymorphic: true
  # same as field :project_tasks, type: Array # [ { proj_id: x, task_ids: [] } ]
  # it will have an id as downside, but parsing won't be needed
  embeds_many :project_tasks, store_as: "prjtsks"

  field :start_date, type: Date
  field :end_date, type: Date
end