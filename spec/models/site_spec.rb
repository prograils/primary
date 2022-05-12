require 'spec_helper'

describe Site do
  before(:each) do
    Site.delete_all
  end

  it "should be marked as default if it's first record" do
    site = FactoryGirl.build(:site)
    site.save
    site.is_default.should == true
  end

  it "should make sure, that there is only one default record" do
    site1 = FactoryGirl.build(:site)
    site1.save
    site1.is_default.should == true
    site2 = FactoryGirl.build(:site, :is_default=>false)
    site2.save
    site1.reload
    site2.reload
    site1.is_default.should == true
    site2.is_default.should == false
    site2.is_default = true
    site2.save
    site1.reload
    site2.reload
    site1.is_default.should == false
    site2.is_default.should == true
  end

  context "#destroy" do
    it "should mark next record as default" do
      site1 = FactoryGirl.create(:site)
      site2 = FactoryGirl.create(:site)
      site1.is_default.should == true
      site2.is_default.should == false
      site1.destroy!
      site2.reload
      site2.is_default.should == true
    end
  end
end
