describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random').to :route_random }
  it { is_expected.to route_command('rand').to :route_random }
  it { is_expected.to route_command('RaNdOm').to :route_random }
  it { is_expected.to route_command('rAnD').to :route_random }

  it { is_expected.to route_command('random 5').to :route_random_to }
  it { is_expected.to route_command('rand 17').to :route_random_to }
  it { is_expected.to route_command('rAnDoM 59827').to :route_random_to }
  it { is_expected.to route_command('RanD 0').to :route_random_to }

  it { is_expected.to route_command('random 0 1').to :route_random_from_to }
  it { is_expected.to route_command('rand 102 26595').to :route_random_from_to }
  it { is_expected.to route_command('rANdOM 16463 0').to :route_random_from_to }
  it { is_expected.to route_command('ranD 10 100').to :route_random_from_to }

  describe '/random' do
    it 'replies in correct format' do
      send_command('random')
      expect(replies.last).to match(/\A\d\.\d+\z/)
    end
  end

  describe '/random <to>' do
    it 'replies in correct format' do
      send_command('random 1')
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      to = 20
      send_command("random #{to}")
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < to
    end
  end

  describe '/random <from> <to>' do
    it 'replies in correct format' do
      send_command('random 0 1')
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      from = 0
      to   = 20
      send_command("random #{from} #{to}")
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= from
      expect(value).to be < to
    end

    it 'replies in correct format' do
      from = 10_000
      to   = 10_010
      send_command("random #{from} #{to}")
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= from
      expect(value).to be < to
    end
  end
end
