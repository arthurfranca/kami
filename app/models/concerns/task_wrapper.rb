module TaskWrapper
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :closed_tasks, inverse_of: :nil

    # even with has_and_belongs_to_many :open_tasks, inverse_of: :nil one would need to set open_task_ids instead of 
    # open_tasks because embedded can't be referenced by anyone but it's parent
    field :o_ids, as: :open_task_ids, type: Array
  end

  def open_tasks
    project.open_tasks.where id: open_task_ids
  end
end