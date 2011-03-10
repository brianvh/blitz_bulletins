require 'acceptance/acceptance_helper'

describe "Listing Blitz Bulletin topics" do
  context "GIVEN: a topics file with 2 topics" do
    before(:each) do
      topics_file = %{Jan  1 04:02 topic-one
        Jan  2 04:02 topic-two
      }.gsub(/^ {8}/, '')
      write_file("data/topics.txt", topics_file)
    end

    context "WHEN: we run `bb-topics list`" do
      before(:each) do
        run_simple('bb-topics list')
      end

      context "THEN: the output of the command" do
        it "should begin with 'topic-one: 01/01/2011'" do
          all_output.should match(/^topic-one: 01\/01\/2011/)
        end
      end
    end
  end
end
