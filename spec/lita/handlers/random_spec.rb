describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random').to :route_random }
  it { is_expected.to route_command('rand').to :route_random }
  it { is_expected.to route_command('RaNdOm').to :route_random }
  it { is_expected.to route_command('rAnD').to :route_random }

  it { is_expected.to route_command('random 5').to :route_random_to }
  it { is_expected.to route_command('rand 17').to :route_random_to }
  it { is_expected.to route_command('rAnDoM 59827').to :route_random_to }
  it { is_expected.to route_command('RanD 0').to :route_random_to }

  it { is_expected.to route_command('random 5.0').to :route_random_float_to }
  it { is_expected.to route_command('rand 17.74826').to :route_random_float_to }
  it { is_expected.to route_command('rAnDoM 5927.1').to :route_random_float_to }
  it { is_expected.to route_command('RanD 0.12397').to :route_random_float_to }

  it { is_expected.to route_command('random 0 1').to :route_random_from_to }
  it { is_expected.to route_command('rand 102 26595').to :route_random_from_to }
  it { is_expected.to route_command('rANdOM 16463 0').to :route_random_from_to }
  it { is_expected.to route_command('ranD 10 100').to :route_random_from_to }

  it do
    is_expected.to route_command('random 0 1.0')
      .to :route_random_float_from_to
  end

  it do
    is_expected.to route_command('rand 102.0 25')
      .to :route_random_float_from_to
  end

  it do
    is_expected.to route_command('rANdOM 13.1 0')
      .to :route_random_float_from_to
  end

  it do
    is_expected.to route_command('ranD 10 0.5')
      .to :route_random_float_from_to
  end

  describe '/random' do
    it 'replies in correct format' do
      send_command('random')
      expect(replies.last).to match(/\A\d\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 0
      expect(value).to be < 1
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

  describe '/random <to:float>' do
    it 'replies in correct format' do
      send_command('random 1.0')
      expect(replies.last).to match(/\A\d\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 0
      expect(value).to be < 1
    end

    it 'replies in correct format' do
      to = 20.0
      send_command("random #{to}")
      expect(replies.last).to match(/\A\d+\.\d+\z/)
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

  describe '/random <from:float> <to:float>' do
    it 'replies in correct format' do
      send_command('random 1.0 2')
      value = replies.last.to_f
      expect(value).to be >= 1
      expect(value).to be < 2
    end

    it 'replies in correct format' do
      send_command('random 5 6.2')
      value = replies.last.to_f
      expect(value).to be >= 5
      expect(value).to be < 6.2
    end

    it 'replies in correct format' do
      from = 0.0
      to   = 20
      send_command("random #{from} #{to}")
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= from
      expect(value).to be < to
    end

    it 'replies in correct format' do
      from = 10_000
      to   = 10_010.0
      send_command("random #{from} #{to}")
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= from
      expect(value).to be < to
    end
  end
end
