class Background < ActiveRecord::Base
  is_primary mark_first: false

  attr_accessible :is_primary, :url
end
