module MfgProcessx
  class MfgProcess < ActiveRecord::Base
    attr_accessor :rfq_name, :customer_name, :rfq_material, :rfq_tech_spec, :composed_by_name, :last_updated_by_name, :void_noupdate
    attr_accessible :composed_by_id, :description, :last_updated_by_id, :name, :note, :rfq_id, :void, :wfid, :process_steps_attributes,
                    :rfq_info, :customer_name, :rfq_material, :rfq_tech_spec,
                    :as => :role_new
    attr_accessible :composed_by_id, :description, :name, :note, :void, :wfid, :process_steps_attributes,
                    :rfq_info, :customer_name, :rfq_material, :rfq_tech_spec, :composed_by_name, :last_updated_by_name, :void_noupdate,
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :composed_by, :class_name => 'Authentify::User' 
    has_many :process_steps, :class_name => 'MfgProcessx::ProcessStep'
    belongs_to :rfq, :class_name => MfgProcessx.rfq_class.to_s
    accepts_nested_attributes_for :process_steps, :allow_destroy => true
    
    validates :name, :presence => true,
                     :uniqueness => {:scope => :rfq_id, :case_sensitive => false, :message => 'Duplicate Name!'}
  end
end
