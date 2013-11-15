class User
  include Mongoid::Document
  include Mongoid::Paranoia # deleted_at

  belongs_to :job
  belongs_to :role

  has_many :allocations
  has_many :requests, class_name: "Task", inverse_of: :requester
  has_many :assignments, class_name: "Task", inverse_of: :resource
  
  has_and_belongs_to_many :specialties

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :address, type: String
  field :is_available, type: Boolean

  field :login, type: String
  field :password, type: String

  def projects
    Project.in(id: allocations.map(&:project_id))
  end
end
