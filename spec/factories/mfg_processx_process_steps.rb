# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mfg_processx_process_step, :class => 'MfgProcessx::ProcessStep' do
    mfg_process_id 1
    name "MyString"
    step_desp "MyText"
    machine_tool_category_id 1
    step_duration_sec "9.99"
    ranking_order 1
    op_cost_hourly 1
    op_desp 'op'
    insp_desp 'insp'
    cutter_desp 'cutter'
  end
end
