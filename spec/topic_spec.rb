require 'spec_helper'

describe BlitzBulletins::Topic do
  let(:name) { 'topic-one' }
  let(:date) { Date.parse('Jan  1 2010') }

  subject { BlitzBulletins::Topic.new(attribs) }

  context "Created without a date" do
    let(:attribs) { {:name => name} }

    its(:name) { should == name }
    its(:short_date) { should == Date.today.strftime("%m/%d/%Y") }

  end

  context "Created with a date" do
    let(:attribs) { {:name => name, :date => date} }

    its(:to_s) { should == 'topic-one: 01/01/2010' }
    its(:to_csv) { should == ['topic-one', '01/01/2010'] }
  end

  context "Created with a date and description" do
    let(:attribs) { {:name => name, :date => date,
                      :description => "Topic One"} }

    its(:to_s) { should == 'Topic One (topic-one): 01/01/2010' }
    its(:to_csv) { should == ['Topic One', 'topic-one', '01/01/2010'] }
  end

  context "Created with a date and 1 subscriber" do
    let(:attribs) { {:name => name, :date => date,
                      :subscribers => 1} }

    its(:to_s) { should == 'topic-one: 01/01/2010 -- 1 subscriber' }
    its(:to_csv) { should == ['topic-one', '01/01/2010', 1] }
  end

  context "Created with a date, description and multiple subscribers" do
    let(:attribs) { {:name => name, :date => date,
                      :description => "Topic One", :subscribers => 2} }

    its(:to_s) { should == 'Topic One (topic-one): 01/01/2010 -- 2 subscribers' }
    its(:to_csv) { should == ['Topic One', 'topic-one', '01/01/2010', 2] }
  end

end
