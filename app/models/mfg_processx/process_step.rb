module MfgProcessx
  class ProcessStep < ActiveRecord::Base
    attr_accessible :op_cost_hourly, :machine_tool_category_id, :mfg_process_id, :name, :ranking_order, :step_desp, :step_duration_sec,
                    :as => :role_new
    attr_accessible :op_cost_hourly, :machine_tool_category_id, :mfg_process_id, :name, :ranking_order, :step_desp, :step_duration_sec,
                    :as => :role_update
    belongs_to :mfg_process, :class_name => 'MfgProcessx::MfgProcess'
    
    validates_presence_of :name
    validates :ranking_order, :presence => true,
                              :numericality => {:integer => true}
  end
end
