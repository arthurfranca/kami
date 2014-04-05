class Company
  include Mongoid::Document

  embeds_many :sprints, as: :sprintish, store_as: "sprts"
  has_many    :projects
end