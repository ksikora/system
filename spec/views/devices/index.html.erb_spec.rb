require 'spec_helper'

describe "devices/index" do
  before(:each) do
    assign(:devices, [
      stub_model(Device,
        :name => "Name",
        :dtype => "Dtype",
        :sends_logs => false
      ),
      stub_model(Device,
        :name => "Name",
        :dtype => "Dtype",
        :sends_logs => false
      )
    ])
  end

  it "renders a list of devices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Dtype".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
