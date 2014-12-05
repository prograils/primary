class Background < ActiveRecord::Base
  is_primary auto_primary_record: false

  attr_accessible :is_primary, :url
end
