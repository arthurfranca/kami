# class BaselineEnd
#   include Mongoid::Document
#   include Mongoid::Versioning #so that the other side embeds_one instead of many

#   embedded_in :project

#   field :date, type: Date
# end