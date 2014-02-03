class CreateMfgProcessxMfgProcesses < ActiveRecord::Migration
  def change
    create_table :mfg_processx_mfg_processes do |t|
      t.integer :rfq_id
      t.string :name
      t.text :description
      t.integer :last_updated_by_id
      t.integer :composed_by_id
      t.boolean :void, :default => false
      t.text :note
      t.string :wfid
      t.string :wf_state

      t.timestamps
    end
    
    add_index :mfg_processx_mfg_processes, :rfq_id
    add_index :mfg_processx_mfg_processes, :wf_state
  end
end
