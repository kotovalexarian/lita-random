describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random  Hx').to :route_random_hex }
  it { is_expected.to route_command('rand  hex').to :route_random_hex }
  it { is_expected.to route_command('rAnDoM HeX').to :route_random_hex }
  it { is_expected.to route_command('RaNd   hx').to :route_random_hex }

  it { is_expected.to route_command('randomHx').to :route_random_hex }
  it { is_expected.to route_command('randhex').to :route_random_hex }
  it { is_expected.to route_command('rAnDoMx').to :route_random_hex }
  it { is_expected.to route_command('RaNdX').to :route_random_hex }

  it { is_expected.to route_command('random  hx  0').to :route_random_hex }
  it { is_expected.to route_command('rand  hEx 284').to :route_random_hex }
  it { is_expected.to route_command('rAnDoM HeX 1').to :route_random_hex }
  it { is_expected.to route_command('RaNd   Hx  4928').to :route_random_hex }

  it { is_expected.to route_command('randomhx  0').to :route_random_hex }
  it { is_expected.to route_command('randhEx 284').to :route_random_hex }
  it { is_expected.to route_command('rAnDoMx 1').to :route_random_hex }
  it { is_expected.to route_command('RaNdX  4928').to :route_random_hex }

  it do
    is_expected.to route_command('random  hx --size 0').to :route_random_hex
  end

  it do
    is_expected.to route_command('rand hEx --size 284').to :route_random_hex
  end

  it { is_expected.to route_command('rAnDoM HeX -s  1').to :route_random_hex }
  it { is_expected.to route_command('RaNd  Hx -s 4928').to :route_random_hex }

  it { is_expected.to route_command('randomhx -s 0').to :route_random_hex }

  it do
    is_expected.to route_command('randhEx --size 284').to :route_random_hex
  end

  it { is_expected.to route_command('rAnDoMx -s 1').to :route_random_hex }

  it { is_expected.to route_command('RaNdX --size 428').to :route_random_hex }

  describe '/random hex' do
    it 'replies in correct format' do
      send_command('random hex')
      expect(replies.last).to match(/\A[0-9a-f]{32}\z/)
    end

    it 'replies in correct format' do
      send_command('randhex')
      expect(replies.last).to match(/\A[0-9a-f]{32}\z/)
    end

    it 'replies in correct format' do
      send_command('random x')
      expect(replies.last).to match(/\A[0-9a-f]{32}\z/)
    end

    # The most important test, because this variant of command is the shortest
    # and it will be used most frequently
    it 'replies in correct format' do
      send_command('randx')
      expect(replies.last).to match(/\A[0-9a-f]{32}\z/)
    end
  end

  describe '/random hex <n>' do
    it 'replies in correct format' do
      send_command('random hex 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('random x 1')
      expect(replies.last).to match(/\A[0-9a-f]{2}\z/)
    end

    it 'replies in correct format' do
      send_command('rand hex 2')
      expect(replies.last).to match(/\A[0-9a-f]{4}\z/)
    end

    it 'replies in correct format' do
      send_command('rand x 10')
      expect(replies.last).to match(/\A[0-9a-f]{20}\z/)
    end

    it 'replies in correct format' do
      send_command('randomhex 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('randomx 1')
      expect(replies.last).to match(/\A[0-9a-f]{2}\z/)
    end

    it 'replies in correct format' do
      send_command('randhex 2')
      expect(replies.last).to match(/\A[0-9a-f]{4}\z/)
    end

    # The most important test, because this variant of command is the shortest
    # and it will be used most frequently
    it 'replies in correct format' do
      send_command('randx 10')
      expect(replies.last).to match(/\A[0-9a-f]{20}\z/)
    end

    it 'replies in correct format' do
      send_command('random hex -s 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('random x --size 1')
      expect(replies.last).to match(/\A[0-9a-f]{2}\z/)
    end

    it 'replies in correct format' do
      send_command('rand hex -s 2')
      expect(replies.last).to match(/\A[0-9a-f]{4}\z/)
    end

    it 'replies in correct format' do
      send_command('rand x -s 10')
      expect(replies.last).to match(/\A[0-9a-f]{20}\z/)
    end

    it 'replies in correct format' do
      send_command('randomhex --size 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('randomx -s 1')
      expect(replies.last).to match(/\A[0-9a-f]{2}\z/)
    end

    it 'replies in correct format' do
      send_command('randhex --size 2')
      expect(replies.last).to match(/\A[0-9a-f]{4}\z/)
    end

    # The most important test, because this variant of command is the shortest
    # and it will be used most frequently
    it 'replies in correct format' do
      send_command('randx --size 10')
      expect(replies.last).to match(/\A[0-9a-f]{20}\z/)
    end
  end
end
