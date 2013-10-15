require 'spec_helper'

module MfgProcessx
  describe ProcessStep do
    it "should be OK" do
      c = FactoryGirl.build(:mfg_processx_process_step)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:mfg_processx_process_step, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject non integer ranking order" do
      c = FactoryGirl.build(:mfg_processx_process_step, :ranking_order => 'nil')
      c.should_not be_valid
    end
    
  end
end
