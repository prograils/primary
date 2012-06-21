class Site < ActiveRecord::Base
  ## GAME CHANGERS
  is_primary :on=>:is_default

  ## SCOPES
  has_many :domains, :dependent=>:destroy

  ## VALIDATIONS
  validates :name,
            :presence   => true,
            :uniqueness => true

  ## ACCESSIBLE
  attr_accessible :is_default, :name

  def to_s
    self.name
  end
end
