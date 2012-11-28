require 'spec_helper'

describe "logs/new" do
  before(:each) do
    assign(:log, stub_model(Log,
      :device_id => 1,
      :content => "MyString",
      :generation_date => 1
    ).as_new_record)
  end

  it "renders new log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => logs_path, :method => "post" do
      assert_select "input#log_device_id", :name => "log[device_id]"
      assert_select "input#log_content", :name => "log[content]"
      assert_select "input#log_generation_date", :name => "log[generation_date]"
    end
  end
end
