class Photo < ActiveRecord::Base
  is_primary :scope=>[:photoable_type, :photoable_id]

  ## ASSOCIATIONS
  belongs_to :photoable, :polymorphic=>true

  ## VALIDATIONS
  #validates :photo_file_name,
            #:presence=>true

  ## ACCESSIBLE
  # attr_accessible :photo_file_name
end
