module Sprint
  extend ActiveSupport::Concern

  included do
    field :endt, as: :end_date, type: Date
  end
end