class Job
  include Mongoid::Document

  has_one :user

  field :name, type: String
  field :salary, type: Float
  field :hours, type: Integer
  field :max_projects, type: Integer
end
