require 'spec_helper'

describe Background do

  context 'auto_primary_record is false' do
    it "should not be marked as default if it's first record" do
      background = FactoryGirl.build(:background)
      background.save
      background.is_primary.should == false
    end

    it "should not be marked as default out of the box" do
      background_1 = FactoryGirl.build(:background)
      background_2 = FactoryGirl.build(:background)

      [background_1, background_2].map(&:save)

      background_1.is_primary.should == false
      background_2.is_primary.should == false
    end

    it "should make sure, that there is only one default record" do
      backgrounds = FactoryGirl.create_list(:background, 3)
      Background.update_all(is_primary: true)

      first_background = Background.first
      first_background.is_primary = true
      first_background.save

      Background.where(is_primary: true).should == [first_background]
    end
  end
end
