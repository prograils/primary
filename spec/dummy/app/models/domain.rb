class Domain < ActiveRecord::Base
  is_primary :scope=>:site_id

  belongs_to :site
  has_many :photos, :as=>:photoable

  # attr_accessible :domain, :is_primary
end
