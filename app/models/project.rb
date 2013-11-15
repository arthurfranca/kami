class Project
  include Mongoid::Document

  has_many :allocations
  embeds_one :baseline_ends # with versioning - acts like embeds_many
  
  has_and_belongs_to_many :specialties

  field :name, type: String
  field :start_date, type: Date

  def users
    User.in(id: allocations.map(&:user_id))
  end
end
