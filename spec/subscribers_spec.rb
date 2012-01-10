require 'spec_helper'

describe BlitzBulletins::Subscribers do
  let(:topic_1) { {:name => "topic-one", :count => 3} }
  let(:topic_2) { {:name => "topic-two", :count => 5} }

  subject { BlitzBulletins::Subscribers.new(sub_list).hash }

  context "When parsing a list of 2 topics with their subcriber counts" do
    let(:sub_list) { ["#{topic_1[:name]}:#{topic_1[:count]}",
                      "#{topic_2[:name]}:#{topic_2[:count]}"] }

    it { should have(2).items }
    its(['topic-one']) { should == topic_1[:count] }
    its(['topic-two']) { should == topic_2[:count] }
  end
end
