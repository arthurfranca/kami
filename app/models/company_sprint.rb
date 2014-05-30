class CompanySprint
  include Mongoid::Document
  include Sprint

  embedded_in :company
  # same as field :project_tasks, type: Array # [ { proj_id: x, open_task_ids: [], closed_task_ids: [] } ]
  # it will have an id as downside, but parsing won't be needed
  embeds_many :project_tasks, store_as: "prjtsks"
end