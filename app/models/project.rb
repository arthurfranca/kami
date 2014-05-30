class Project
  include Mongoid::Document

  embeds_many :sprints, class_name: "ProjectSprint", store_as: "sprts"
  embeds_many :open_tasks,                           store_as: "o_ts"
  has_many    :closed_tasks
  has_and_belongs_to_many :allocateds, class_name: "User", inverse_of: :allocation
  belongs_to  :company
  
  field :name,                     type: String
  field :stdt, as: :start_date,    type: Date
  field :bsed, as: :baseline_ends, type: Array
  field :avlb, as: :is_available,  type: Boolean

  def users
    User.in(id: allocations.map(&:user_id))
  end
end
