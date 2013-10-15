require "mfg_processx/engine"

module MfgProcessx
  mattr_accessor :rfq_class
  
  def self.rfq_class
    @@rfq_class.constantize
  end
end
