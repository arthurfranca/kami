class ProjectTask # used on CompanySprint just to keep project + tasks info
  include Mongoid::Document
  include TaskWrapper

  embedded_in :company_sprint
  belongs_to  :project
end