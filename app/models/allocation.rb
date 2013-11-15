class Allocation
  include Mongoid::Document

  belongs_to :user
  belongs_to :project

  field :hours, type: Integer
end
