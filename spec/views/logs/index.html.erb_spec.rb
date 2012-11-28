require 'spec_helper'

describe "logs/index" do
  before(:each) do
    assign(:logs, [
      stub_model(Log,
        :device_id => 1,
        :content => "Content",
        :generation_date => 2
      ),
      stub_model(Log,
        :device_id => 1,
        :content => "Content",
        :generation_date => 2
      )
    ])
  end

  it "renders a list of logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
