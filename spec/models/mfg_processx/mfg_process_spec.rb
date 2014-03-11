require 'spec_helper'

module MfgProcessx
  describe MfgProcess do
    it "should be OK" do
      step = FactoryGirl.build(:mfg_processx_process_step)
      c = FactoryGirl.build(:mfg_processx_mfg_process, :process_steps => [step] )
      c.should be_valid
    end
    
    it "should reject nil name" do
      step = FactoryGirl.build(:mfg_processx_process_step)
      c = FactoryGirl.build(:mfg_processx_mfg_process, :name => nil, :process_steps => [step])
      c.should_not be_valid
    end
    
    it "should reject dup name" do
      step = FactoryGirl.build(:mfg_processx_process_step)
      c1 = FactoryGirl.create(:mfg_processx_mfg_process,  :process_steps => [step])
      c = FactoryGirl.build(:mfg_processx_mfg_process,  :process_steps => [step])
      c.should_not be_valid
    end
    
    it "should reject 0 rfq_id" do
      step = FactoryGirl.build(:mfg_processx_process_step)
      c = FactoryGirl.build(:mfg_processx_mfg_process, :rfq_id => 0, :process_steps => [step])
      c.should_not be_valid
    end
    
  end
end
