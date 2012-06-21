class Domain < ActiveRecord::Base
  is_primary :scope=>:site_id

  belongs_to :site
  attr_accessible :domain, :is_primary
end
