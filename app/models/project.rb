class Project
  include Mongoid::Document

  embeds_many :sprints, as: :sprintish, store_as: "sprts"
  embeds_many :open_tasks,              store_as: "o_ts"
  has_many    :closed_tasks
  has_and_belongs_to_many :allocateds, class_name: "User", inverse_of: :allocation
  belongs_to  :company
  
  field :name,         type: String
  field :start_date,   type: Date
  field :baseline_end, type: Array
  field :is_available, type: Boolean

  def users
    User.in(id: allocations.map(&:user_id))
  end
end
