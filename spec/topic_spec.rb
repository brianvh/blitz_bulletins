require 'spec_helper'

describe BlitzBulletins::Topic do
  before(:each) do
    @name = 'topic-one'
    @date = 'Jan  1 2010'
  end

  context "When creating a new instance" do
    context "without a date" do
      before(:each) do
        @topic = BlitzBulletins::Topic.new(@name)
      end

      describe "#name" do
        it "returns the correct name" do
          @topic.name.should == @name
        end
      end

      describe "#date" do
        it "returns today as the date" do
          @topic.date.should == Date.today
        end
      end
    end

    context "with a date" do
      before(:each) do
        @topic = BlitzBulletins::Topic.new(@name, Date.parse(@date))
      end

      describe "#to_s" do
        it "returns the correct output" do
          @topic.to_s.should == 'topic-one: 01/01/2010'
        end
      end

      describe "#to_csv" do
        it "returns the correct array" do
          @topic.to_csv.should == ['topic-one', '01/01/2010']
        end
      end
    end

    context "with a date and description" do
      before(:each) do
        @topic = BlitzBulletins::Topic.new(@name, Date.parse(@date), true)
        @topic.should_receive(:get_description).once.and_return("Topic One")
      end

      describe "#to_s" do
        it "returns the correct output" do
          @topic.to_s.should == 'Topic One (topic-one): 01/01/2010'
        end
      end

      describe "#to_csv" do
        it "returns the correct array" do
          @topic.to_csv.should == ['Topic One', 'topic-one', '01/01/2010']
        end
      end
    end
  end

  context "When parsing a line from a topics file" do
    before(:each) do
      @topic = BlitzBulletins::Topic.from_line("#{@date} #{@name}")
    end

    describe "#to_s" do
      it "returns the correct output" do
        @topic.to_s.should == 'topic-one: 01/01/2010'
      end
    end
  end
end
