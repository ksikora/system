require 'spec_helper'

describe "devices/new" do
  before(:each) do
    assign(:device, stub_model(Device,
      :name => "MyString",
      :dtype => "MyString",
      :sends_logs => false
    ).as_new_record)
  end

  it "renders new device form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => devices_path, :method => "post" do
      assert_select "input#device_name", :name => "device[name]"
      assert_select "input#device_dtype", :name => "device[dtype]"
      assert_select "input#device_sends_logs", :name => "device[sends_logs]"
    end
  end
end
