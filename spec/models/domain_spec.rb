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

  context "#destroy" do
    it "should mark next same 'parent' record as default" do
      p1 = FactoryGirl.create(:domain, :site=>@site1)
      p2 = FactoryGirl.create(:domain, :site=>@site1)
      p3 = FactoryGirl.create(:domain, :site=>@site1)
      p1.reload
      p2.reload
      p3.reload
      p1.is_primary.should == true
      p2.is_primary.should == false
      p3.is_primary.should == false
      p1.destroy!
      p2.reload
      p3.reload
      p2.is_primary.should == true
      p3.is_primary.should == false
    end

    it "should not touch default record of different 'parents'" do
      p1 = FactoryGirl.create(:domain, :site=>@site1)
      p2 = FactoryGirl.create(:domain, :site=>@site1)
      p3 = FactoryGirl.create(:domain, :site=>@site2)
      p4 = FactoryGirl.create(:domain, :site=>@site2)
      p1.reload
      p2.reload
      p3.reload
      p4.reload
      p1.is_primary.should == true
      p2.is_primary.should == false
      p3.is_primary.should == true
      p4.is_primary.should == false
      p1.destroy!
      p2.reload
      p3.reload
      p4.reload
      p2.is_primary.should == true
      p3.is_primary.should == true
      p4.is_primary.should == false
    end
  end
end
