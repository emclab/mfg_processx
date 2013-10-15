require_dependency "mfg_processx/application_controller"

module MfgProcessx
  class MfgProcessesController < ApplicationController
    before_filter :require_employee
    before_filter :load_rfq
    
    def index
      @title = t('Mfg Processes')
      @mfg_processes = params[:mfg_processx_mfg_processes][:model_ar_r]
      @mfg_processes = @mfg_processes.where(:rfq_id => @rfq.id) if @rfq
      @mfg_processes = @mfg_processes.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('mfg_process_index_view', 'mfg_processx_mfg_processes')
    end
  
    def new
      @title = t('New Mfg Processe')
      @mfg_process = MfgProcessx::MfgProcess.new()
      @erb_code = find_config_const('mfg_process_new_view', 'mfg_processx_mfg_processes')
    end
  
    def create
      @mfg_process = MfgProcessx::MfgProcess.new(params[:mfg_process], :as => :role_new)
      @mfg_process.last_updated_by_id = session[:user_id]
      @mfg_process.composed_by_id = session[:user_id]
      if @mfg_process.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Mfg Processe')
      @mfg_process = MfgProcessx::MfgProcess.find_by_id(params[:id])
      @erb_code = find_config_const('mfg_process_edit_view', 'mfg_processx_mfg_processes')
    end
  
    def update
      @mfg_process = MfgProcessx::MfgProcess.find_by_id(params[:id])
      @mfg_process.last_updated_by_id = session[:user_id]
      if @mfg_process.update_attributes(params[:mfg_process], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Mfg Processe Info')
      @mfg_process = MfgProcessx::MfgProcess.find_by_id(params[:id])
      @erb_code = find_config_const('mfg_process_show_view', 'mfg_processx_mfg_processes')
    end
    
    protected
    def load_rfq
      @rfq = MfgProcessx.rfq_class.find_by_id(params[:rfq_id]) if params[:rfq_id].present?
      @rfq = MfgProcessx.rfq_class.find_by_id(MfgProcessx::MfgProcess.find_by_id(params[:id]).rfq_id) if params[:id].present?
    end
  end
end
