require 'spec_helper'

describe "LinkTests" do
  describe "GET /mfg_processx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur], :login => 'thistest', :password => 'password', :password_confirmation => 'password')
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "MfgProcessx::MfgProcess.where(:void => false).order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "record.rfq.sales_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.rfq.sales_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'create_rfq', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        
      @cust = FactoryGirl.create(:kustomerx_customer) 
      @rfq = FactoryGirl.create(:jobshop_rfqx_rfq, :customer_id => @cust.id, :sales_id => @u.id)
      @rfq1 = FactoryGirl.create(:jobshop_rfqx_rfq, :product_name => 'new name', :drawing_num => '12345', :customer_id => @cust.id, :sales_id => @u.id) 
            
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
    end
    
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      q = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq1.id, :name => 'process name')
      visit mfg_processes_path
      #save_and_open_page
      page.should have_content('Mfg Processes')
      click_link('Edit')
      page.should have_content('Edit Mfg Process')
      visit new_mfg_process_path(rfq_id: @rfq.id)
      page.should have_content('New Mfg Process')
      visit edit_mfg_process_path(q, rfq_id: @rfq1.id)
      page.should have_content('Edit Mfg Process')
      visit mfg_process_path(q, rfq_id: @rfq1.id)
      page.should have_content('Mfg Process Info')
    end
    
    it "check new mfg process link" do
      q = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq.id, :name => 'process name')
      visit mfg_processes_path(rfq_id: @rfq.id)
      #save_and_open_page
      click_link('New Mfg Process')
      page.should have_content('New Mfg Process')
    end
  end
end
