module NotSti::Task
  def self.extended(base)
    base.instance_eval do
      belongs_to :requester,            class_name: "User"                   # requester_id
      has_and_belongs_to_many :workers, class_name: "User", inverse_of: :nil # worker_ids
      has_and_belongs_to_many :tags,                        inverse_of: :nil
      embeds_many :first_page_comments, store_as: "f_cmnts" # limit to 30; beyond this will be lazily loaded
      has_many    :additional_comments # so that document never exceeds size limit

      field :title,       type: String
      field :description, type: String
      field :comment,     type: String
    end
  end
end