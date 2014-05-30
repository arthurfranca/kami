module Task
  extend ActiveSupport::Concern

  included do
    belongs_to :requester,            class_name: "User"                   # requester_id
    has_and_belongs_to_many :workers, class_name: "User", inverse_of: :nil # worker_ids
    has_and_belongs_to_many :tags,                        inverse_of: :nil
    # limit to 30; beyond this will be lazily loaded
    # so that document never exceeds size limit
    embeds_many :first_page_comments, as: :commentable, store_as: "f_cmnts"
    has_many    :additional_comments, as: :commentable

    field :titl, as: :title,       type: String
    field :desc, as: :description, type: String
    field :actv, as: :active,      type: Boolean
  end
end