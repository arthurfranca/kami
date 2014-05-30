class Tag
  include Mongoid::Document

  belongs_to :company

  field :name,             type: String
  field :colr, as: :color, type: String
end