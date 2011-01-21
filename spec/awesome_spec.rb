require "spec_helper"

describe AgileZen::Awesome do
  it "is awesome" do
    AgileZen::Awesome.new.describe.should be_awesome
  end
end