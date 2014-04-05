class Tag
  include Mongoid::Document

  belongs_to :company

  field :name,  type: String
  field :color, type: String
end