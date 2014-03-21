class Project
  include Mongoid::Document

  # embeds_one :baseline_ends # with versioning - acts like embeds_many

  has_many :allocations
  has_many :tasks
  
  has_and_belongs_to_many :specialties

  accepts_nested_attributes_for :allocations, :specialties

  field :name, type: String
  field :start_date, type: Date
  field :baseline_end, type: Array

  def users
    User.in(id: allocations.map(&:user_id))
  end
end
