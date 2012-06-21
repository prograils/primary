require 'spec_helper'

describe Domain do
  before(:each) do
    @site1 = FactoryGirl.create(:site)
    @site2 = FactoryGirl.create(:site)
  end
  it "should be marked as default it it's first record for it's parent record" do
    d1 = FactoryGirl.create(:domain, :site=>@site1)
    d1.is_primary.should == true
    d2 = FactoryGirl.create(:domain, :site=>@site2)
    d1.reload
    d2.reload
    d1.is_primary.should == true
    d2.is_primary.should == true
  end
  
  it "should not touch default record of different 'parents'" do
    d1 = FactoryGirl.create(:domain, :site=>@site1)
    d2 = FactoryGirl.create(:domain, :site=>@site2)
    d3 = FactoryGirl.create(:domain, :site=>@site1)
    d1.reload
    d2.reload
    d3.reload
    d1.is_primary.should == true
    d2.is_primary.should == true
    d3.is_primary.should == false
    d3.is_primary = true
    d3.save
    d1.reload
    d2.reload
    d3.reload
    d1.is_primary.should == false
    d2.is_primary.should == true
    d3.is_primary.should == true
  end
end
