require 'acceptance/acceptance_helper'

describe "Listing Blitz Bulletin topics" do

  let(:topics) { ['Jan  1 2011 topic-one', 'Feb  1 2011 topic-two'] }
  let(:descs) { ['topic-one:Topic One', 'topic-two:Topic Two'] }
  let(:subs) { ['topic-one:3', 'topic-two:5'] }
  let(:posters) { ['50843:dartmouth.bulletins.topic-one', '57794:dartmouth.bulletins.topic-two'] }

  subject { all_output.split(/\n/) }

  context "GIVEN: a topics file with 2 topics" do
    before { set_topics(topics) }

    context "WHEN: we run `bb-topics list --format=plain`" do
      before { run_simple('bb-topics list --format=plain') }

      it "the output should contain 2 lines" do
        subject.should have(2).items
      end

      it "the 1st line of output should be 'topic-one: 01/01/2011'" do
        subject[0].should == 'topic-one: 01/01/2011'
      end

      it "the 2nd line of output should be 'topic-two: 02/01/2011'" do
        subject[1].should == 'topic-two: 02/01/2011'
      end
    end

    context "WHEN: we run `bb-topics list --format=csv`" do
      let(:lines) {[ ['topic-one', '01/01/2011'], ['topic-two', '02/01/2011'] ]}

      before { run_simple('bb-topics list --format=csv') }

      it "the output should contain 2 lines" do
        subject.should have(2).items
      end

      it "the 1st line of output should be the CSV for topic-one" do
        subject[0].should == lines[0].join(', ')
      end

      it "the 2nd line of output should be the CSV for topic-two" do
        subject[1].should == lines[1].join(', ')
      end
    end

    context "WHEN: we run `bb-topics list --before=2/1/2011`" do
      before { run_simple('bb-topics list --before=2/1/2011') }

      it "the output should be topic-one: 01/01/2011" do
        subject[0].should == 'topic-one: 01/01/2011'
      end
    end

    context "WHEN: we run `bb-topics list --after=2/1/2011`" do
      before { run_simple('bb-topics list --after=2/1/2011') }

      it "the output should be topic-two: 02/01/2011" do
        subject[0].should == 'topic-two: 02/01/2011'
      end
    end

    context "GIVEN: a description file for the two topics" do
      let(:lines) {['Topic One (topic-one): 01/01/2011',
                    'Topic Two (topic-two): 02/01/2011' ]}

      before { set_descriptions(descs) }

      context "WHEN: we run `bb-topics list --descriptions" do
        before { run_simple('bb-topics list --descriptions') }

        it "the 1st line of the output should describe topic-one" do
          subject[0].should == lines[0]
        end

        it "the 2nd line of the output should describe topic-two" do
          subject[1].should == lines[1]
        end
      end
    end

    context "GIVEN: a subscribers file for the two topics" do
      before { set_subscribers(subs) }

      context "WHEN: we run `bb-topics list --subscribers" do
        before { run_simple('bb-topics list --subscribers') }

        it "the output should contain 2 lines" do
          subject.should have(2).items
        end

        it "the 1st line of output should contain the count for topic-one" do
          subject[0].should match(/ -- 3 subscribers$/)
        end

        it "the 2nd line of output should contain the count for topic-two" do
          subject[1].should match(/ -- 5 subscribers$/)
        end
      end
    end

    context "GIVEN: a file of posters for the two topics" do
      before { set_posters(posters) }

      context "WHEN: we run `bb-topics list --posters" do
        before { run_simple('bb-topics list --posters') }

        it "the output should contain 4 lines" do
          subject.should have(4).items
        end

        it "the 2nd line of output should be topic-one's poster" do
          subject[1].should == '    Webmaster'
        end

        it "the 4th line of output should topic-two's poster" do
          subject[3].should == '    Bulletin Administration'
        end
      end
    end

    context "GIVEN: descriptions, subscribers and posters files" do
      let(:lines) { [ ['Topic One', 'topic-one', '01/01/2011', 3, 'Webmaster@Dartmouth.EDU'],
                      ['Topic Two', 'topic-two', '02/01/2011', 5, 'Bulletin.Administration@Dartmouth.EDU'] ]}

      before do
        set_descriptions(descs)
        set_posters(posters)
        set_subscribers(subs)
      end

      context "WHEN: we run `bb-topic list -p -d -s -f=csv" do
        before { run_simple('bb-topics list -p -d -s -f=csv') }

        it "the 1st line of output should be the CSV for topic-one, with the poster" do
          subject[0].should == lines[0].join(', ')
        end

        it "the 2nd line of output should be the CSV for topic-two, with the poster" do
          subject[1].should == lines[1].join(', ')
        end
      end
    end
  end
end
