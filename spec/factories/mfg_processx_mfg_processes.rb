# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mfg_processx_mfg_process, :class => 'MfgProcessx::MfgProcess' do
    rfq_id 1
    name "MyString"
    description "MyText"
    last_updated_by_id 1
    composed_by_id 1
    void false
    note "MyText"
    wfid "MyString"
  end
end
