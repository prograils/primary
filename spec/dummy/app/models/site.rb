class Site < ActiveRecord::Base
  ## GAME CHANGERS
  is_primary :on=>:is_default

  ## ASSOCIATIONS
  has_many :domains, :dependent=>:destroy
  has_many :photos, :dependent=>:destroy, :as=>:photoable

  ## VALIDATIONS
  validates :name,
            :presence   => true,
            :uniqueness => true

  ## ACCESSIBLE
  # attr_accessible :is_default, :name

  def to_s
    self.name
  end
end
