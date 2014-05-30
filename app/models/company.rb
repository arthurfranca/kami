class Company
  include Mongoid::Document

  embeds_many :sprints, class_name: "CompanySprint", store_as: "sprts"
  has_many    :projects
end