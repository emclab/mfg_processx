require 'spec_helper'

module MfgProcessx
  describe MfgProcessesController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      #engine_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => "t('set'), t('piece')")
    end
    
    before(:each) do
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      @cust = FactoryGirl.create(:kustomerx_customer) 
      @rfq = FactoryGirl.create(:jobshop_rfqx_rfq, :customer_id => @cust.id, :sales_id => @u.id)
      @rfq1 = FactoryGirl.create(:jobshop_rfqx_rfq, :product_name => 'new name', :drawing_num => '12345', :customer_id => @cust.id, :sales_id => @u.id)  
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all mfg processes" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MfgProcessx::MfgProcess.where(:void => false).order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq1.id)
        q1 = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq.id)
        get 'index', {:use_route => :mfg_processx}
        assigns(:mfg_processes).should =~ [q, q1]
      end
      
      it "returns the mfg processess for the rfq" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MfgProcessx::MfgProcess.where(:void => false).order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq1.id)
        q1 = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq.id)
        get 'index', {:use_route => :mfg_processx, :rfq_id => @rfq.id}
        assigns(:mfg_processes).should =~ [q1]
      end
      
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :mfg_processx, :rfq_id => @rfq.id}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:mfg_processx_mfg_process)
        get 'create', {:use_route => :mfg_processx, :rfq_id => @rfq.id, :mfg_process => q}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:mfg_processx_mfg_process, :name => nil)
        get 'create', {:use_route => :mfg_processx, :rfq_id => @rfq1.id, :mfg_process => q}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:mfg_processx_mfg_process)
        get 'edit', {:use_route => :mfg_processx, :id => q.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:mfg_processx_mfg_process)
        get 'update', {:use_route => :mfg_processx, :id => q.id, :rfq => {:material_requirement => 'steel 201'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:mfg_processx_mfg_process)
        get 'update', {:use_route => :mfg_processx, :id => q.id, :mfg_process => {:name => ''}}
        response.should render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'mfg_processx_mfg_processes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.rfq.sales_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:mfg_processx_mfg_process, :rfq_id => @rfq.id)
        get 'show', {:use_route => :mfg_processx, :id => q.id, :rfq_id => @rfq.id}
        response.should be_success
      end
    end
  
  end
end
