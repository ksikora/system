require 'spec_helper'

describe "logs/show" do
  before(:each) do
    @log = assign(:log, stub_model(Log,
      :device_id => 1,
      :content => "Content",
      :generation_date => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Content/)
    rendered.should match(/2/)
  end
end
