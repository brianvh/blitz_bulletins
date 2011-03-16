require 'acceptance/acceptance_helper'

describe "Listing Blitz Bulletin topics" do
  context "GIVEN: a topics file with 2 topics" do
    before(:each) do
      set_topics(['Jan  1 04:02 topic-one', 'Feb  1 04:02 topic-two'])
    end

    context "WHEN: we run `bb-topics list`" do
      before(:each) do
        run_simple('bb-topics list')
      end

      context "THEN: the output of the command" do
        it "should begin with 'topic-one: 01/01/2011'" do
          all_output.should match(/^topic-one: 01\/01\/2011/)
        end

        it "should end with 'topic-two: 02/01/2011'" do
          all_output.should match(/topic-two: 02\/01\/2011$/)
        end
      end
    end

    context "WHEN: we run `bb-topics list --before=2/1/2011`" do
      before(:each) do
        run_simple('bb-topics list --before=2/1/2011')
      end

      context "THEN: the output should be" do
        it "topic-one: 01/01/2011" do
          output_text.should == 'topic-one: 01/01/2011'
        end
      end
    end

    context "WHEN: we run `bb-topics list --after=2/1/2011`" do
      before(:each) do
        run_simple('bb-topics list --after=2/1/2011')
      end

      context "THEN: the output should be" do
        it "topic-two: 02/01/2011" do
          output_text.should == 'topic-two: 02/01/2011'
        end
      end
    end

    context "GIVEN: a description file for the two topics" do
      before(:each) do
        set_descriptions(['topic-one:Topic One', 'topic-two:Topic Two'])
      end

      context "WHEN: we run `bb-topics list --descriptions" do
        before(:each) do
          run_simple('bb-topics list --descriptions')
        end

        context "THEN: the output of the run" do
          it "should begin with 'Topic One (topic-one): 01/01/2011'" do
            all_output.should match(/^Topic One \(topic-one\): 01\/01\/2011/)
          end

          it "should end with 'Topic Two (topic-two): 02/01/2011'" do
            all_output.should match(/Topic Two \(topic-two\): 02\/01\/2011$/)
          end
        end
      end
    end

    context "GIVEN: a file of posters for the two topics" do
      before(:each) do
        set_posters(['50843:dartmouth.bulletins.topic-one', '57794:dartmouth.bulletins.topic-two'])
      end

      context "WHEN: we run `bb-topics list --posters" do
        before(:each) do
          run_simple('bb-topics list --posters')
        end

        context "THEN: the output of the run" do
          it "should contain 'Webmaster'" do
            all_output.should match(/^    Webmaster/)
          end

          it "should end with 'Bulletin Administration'" do
            all_output.should match(/    Bulletin Administration$/)
          end
        end
      end
    end

    context "GIVEN: descriptions and posters files" do
      before(:each) do
        set_descriptions(['topic-one:Topic One', 'topic-two:Topic Two'])
        set_posters(['50843:dartmouth.bulletins.topic-one', '57794:dartmouth.bulletins.topic-two'])
      end

      context "WHEN: we run `bb-topic list -p -d" do
        before(:each) do
          run_simple('bb-topics list -p -d')
        end

        context "THEN: the output of the run" do
          it "should contain 'Webmaster'" do
            all_output.should match(/^    Webmaster/)
          end

          it "should end with 'Bulletin Administration'" do
            all_output.should match(/    Bulletin Administration$/)
          end
        end
      end
    end
  end
end

describe "Outputting CSV formatted topics" do
  context "GIVEN: a topics file with 2 topics" do
    before(:each) do
      set_topics(['Jan  1 04:02 topic-one', 'Feb  1 04:02 topic-two'])
    end

    context "WHEN: we run `bb-topics csv`" do
      before(:each) do
        run_simple('bb-topics csv')
      end

      context "THEN: the output of the command" do
        it "should begin with 'topic-one, 01/01/2011'" do
          all_output.should match(/^topic-one, 01\/01\/2011/)
        end

        it "should end with 'topic-two, 02/01/2011'" do
          all_output.should match(/topic-two, 02\/01\/2011$/)
        end
      end
    end

    context "GIVEN: descriptions and posters files" do
      before(:each) do
        set_descriptions(['topic-one:Topic One', 'topic-two:Topic Two'])
        set_posters(['50843:dartmouth.bulletins.topic-one', '57794:dartmouth.bulletins.topic-two'])
      end

      context "WHEN: we run `bb-topic csv -p -d" do
        before(:each) do
          run_simple('bb-topics csv -p -d')
        end

        context "THEN: the output of the run" do
          it "should start with 'Topic One, topic-one, 01/01/2011, Webmaster@Dartmouth.EDU'" do
            all_output.should match(/^Topic One, topic-one, 01\/01\/2011, Webmaster@Dartmouth\.EDU/)
          end

          it "should end with 'Topic Two, topic-two, 02/01/2011, Bulletin.Administration@Dartmouth.EDU'" do
            all_output.should match(/Topic Two, topic-two, 02\/01\/2011, Bulletin\.Administration@Dartmouth\.EDU$/)
          end
        end
      end
    end
  end
end
