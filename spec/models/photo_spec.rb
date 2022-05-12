require 'spec_helper'

describe Photo do
  before(:each) do
    @site1 = FactoryGirl.create(:site)
    @site2 = FactoryGirl.create(:site)
    @domain = FactoryGirl.create(:domain, :site=>@site1)
  end

  it "should be marked as default it it's first record for it's parent record" do
    p1 = FactoryGirl.create(:photo, :photoable=>@site1)
    p1.is_primary.should == true
    p2 = FactoryGirl.create(:photo, :photoable=>@site2)
    p3 = FactoryGirl.create(:photo, :photoable=>@domain)
    p1.reload
    p2.reload
    p3.reload
    p1.is_primary.should == true
    p2.is_primary.should == true
    p3.is_primary.should == true
  end

  it "should not touch default record of different 'parents'" do
    p1 = FactoryGirl.create(:photo, :photoable=>@site1)
    p2 = FactoryGirl.create(:photo, :photoable=>@site2)
    p3 = FactoryGirl.create(:photo, :photoable=>@site1)
    p4 = FactoryGirl.create(:photo, :photoable=>@domain)
    p1.reload
    p2.reload
    p3.reload
    p4.reload
    p1.is_primary.should == true
    p2.is_primary.should == true
    p3.is_primary.should == false
    p4.is_primary.should == true
    p3.is_primary = true
    p3.save
    p1.reload
    p2.reload
    p3.reload
    p1.is_primary.should == false
    p2.is_primary.should == true
    p3.is_primary.should == true
    p4.is_primary.should == true
  end

  context "#destroy" do
    it "should mark next same 'parent' record as default" do
      p1 = FactoryGirl.create(:photo, :photoable=>@site1)
      p2 = FactoryGirl.create(:photo, :photoable=>@site1)
      p3 = FactoryGirl.create(:photo, :photoable=>@site1)
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
      p1 = FactoryGirl.create(:photo, :photoable=>@site1)
      p2 = FactoryGirl.create(:photo, :photoable=>@site1)
      p3 = FactoryGirl.create(:photo, :photoable=>@site2)
      p4 = FactoryGirl.create(:photo, :photoable=>@site2)
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

