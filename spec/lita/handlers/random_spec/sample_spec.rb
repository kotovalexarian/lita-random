describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('sAmPlE').to :route_sample }
  it { is_expected.to route_command('SaMpLe   a').to :route_sample }
  it { is_expected.to route_command('sAMpLE A,   b').to :route_sample }
  it { is_expected.to route_command('SamPle  a, B,  c').to :route_sample }
  it { is_expected.to route_command('saMPle 1').to :route_sample }
  it { is_expected.to route_command('SAmpLE   1, b').to :route_sample }
  it { is_expected.to route_command('saMplE 1,   2, 3').to :route_sample }
  it { is_expected.to route_command('samPLe 1,b,C').to :route_sample }
  it { is_expected.to route_command('sAmple  1,2,3').to :route_sample }

  it { is_expected.to route_command('SaMpLe 1  a').to :route_sample }
  it { is_expected.to route_command('sAMpLE  1703 A,   b').to :route_sample }
  it { is_expected.to route_command('SamPle   2 a, B,  c').to :route_sample }
  it { is_expected.to route_command('saMPle 98 1').to :route_sample }
  it { is_expected.to route_command('SAmpLE  746  1, b').to :route_sample }
  it { is_expected.to route_command('saMplE 9 1,   2, 3').to :route_sample }
  it { is_expected.to route_command('samPLe  3 1,b,C').to :route_sample }
  it { is_expected.to route_command('sAmple 147  1,2,3').to :route_sample }

  describe '/sample <array, ...>' do
    it 'replies in correct format' do
      send_command 'sAmplE'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'sAMpLe  123'
      expect(replies.last).to eq '123'
    end

    it 'replies in correct format' do
      send_command 'SAMPLE  foo  bar'
      expect(replies.last).to eq 'foo  bar'
    end

    it 'replies in correct format' do
      send_command 'SAMPLE  foo  bar,car  cdr'
      expect(['foo  bar', 'car  cdr'])
        .to include replies.last
    end

    it 'replies in correct format' do
      send_command 'SAMPLE  foo  bar   ,   car  cdr'
      expect(['foo  bar', 'car  cdr'])
        .to include replies.last
    end

    it 'replies in correct format' do
      send_command 'SAMPLE  foo  bar,car  cdr,123  456'
      expect(['foo  bar', 'car  cdr', '123  456'])
        .to include replies.last
    end

    it 'replies in correct format' do
      send_command 'SAMPLE  foo  bar  ,car  cdr,   123  456'
      expect(['foo  bar', 'car  cdr', '123  456'])
        .to include replies.last
    end
  end

  describe '/sample <count> <array, ...>' do
    it 'replies in correct format' do
      send_command 'sample  0  a'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'sample  1  foo'
      expect(replies.last).to eq 'foo'
    end

    it 'replies in correct format' do
      send_command 'sample  2  a'
      expect(replies.last).to eq 'a'
    end

    it 'replies in correct format' do
      send_command 'sample  0  foo,bar'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'sample  1  foo,bar'
      expect(%w(foo bar)).to include replies.last
    end

    it 'replies in correct format' do
      send_command 'sample  2  foo  ,  bar'
      expect(replies.last.split(',').map(&:lstrip))
        .to match_array %w(foo bar)
    end

    it 'replies in correct format' do
      send_command 'sample  3  a,b'
      expect(replies.last.split(',').map(&:lstrip))
        .to match_array %w(a b)
    end
  end
end
