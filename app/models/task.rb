class Task
  include Mongoid::Document

  belongs_to :requester, class_name: "User", inverse_of: requests
  belongs_to :resource, class_name: "User", inverse_of: assignments

  field :title, String
  field :comment, String
end
