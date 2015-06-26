describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random  base64').to :route_random_base64 }
  it { is_expected.to route_command('rand  base64').to :route_random_base64 }
  it { is_expected.to route_command('rAnDoM bAsE64').to :route_random_base64 }
  it { is_expected.to route_command('RaNd   BaSe64').to :route_random_base64 }

  it { is_expected.to route_command('randombase64').to :route_random_base64 }
  it { is_expected.to route_command('randbase64').to :route_random_base64 }
  it { is_expected.to route_command('rAnDoMb64').to :route_random_base64 }
  it { is_expected.to route_command('RaNdB64').to :route_random_base64 }

  it do
    is_expected.to route_command('random  base64 0').to :route_random_base64
  end

  it do
    is_expected.to route_command('rand  base64  523').to :route_random_base64
  end

  it do
    is_expected.to route_command('rAnDoM bAsE64 5').to :route_random_base64
  end

  it do
    is_expected.to route_command('RaNd BaSe64   4925').to :route_random_base64
  end

  it do
    is_expected.to route_command('randombase64 0').to :route_random_base64
  end

  it { is_expected.to route_command('randbase64 23').to :route_random_base64 }
  it { is_expected.to route_command('rAnDoMb64 5').to :route_random_base64 }
  it { is_expected.to route_command('RaNdB64  4925').to :route_random_base64 }

  it do
    is_expected.to route_command('random  base64 --length 0')
      .to :route_random_base64
  end

  it do
    is_expected.to route_command('rand  base64  -l 523')
      .to :route_random_base64
  end

  it do
    is_expected.to route_command('rAnDoM bAsE64 -l 5').to :route_random_base64
  end

  it do
    is_expected.to route_command('RaNd BaSe64  --length  4925')
      .to :route_random_base64
  end

  it do
    is_expected.to route_command('randombase64 -l  0').to :route_random_base64
  end

  it do
    is_expected.to route_command('randbase64  --length 23')
      .to :route_random_base64
  end

  it do
    is_expected.to route_command('rAnDoMb64 -l  5').to :route_random_base64
  end

  it do
    is_expected.to route_command('RaNdB64  --length 4925')
      .to :route_random_base64
  end

  describe '/random base64' do
    it 'replies in correct format' do
      send_command('random base64')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{22}==\z}
    end

    it 'replies in correct format' do
      send_command('rand b64')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{22}==\z}
    end

    it 'replies in correct format' do
      send_command('randbase64')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{22}==\z}
    end

    it 'replies in correct format' do
      send_command('randomb64')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{22}==\z}
    end

    # The most important test, because this variant of command is the shortest
    # and it will be used most frequently
    it 'replies in correct format' do
      send_command('randb64')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{22}==\z}
    end
  end

  describe '/random base64 <n>' do
    it 'replies in correct format' do
      send_command('random base64 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('randombase64 1')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{2}==\z}
    end

    it 'replies in correct format' do
      send_command('random b64 2')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{3}=\z}
    end

    it 'replies in correct format' do
      send_command('randbase64 3')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{4}\z}
    end

    it 'replies in correct format' do
      send_command('randomb64 34')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{46}==\z}
    end

    # The most important test, because this variant of command is the shortest
    # and it will be used most frequently
    it 'replies in correct format' do
      send_command('randb64 35')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{47}=\z}
    end

    it 'replies in correct format' do
      send_command('random base64  -l 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('randombase64 --length  1')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{2}==\z}
    end

    it 'replies in correct format' do
      send_command('random b64 -l  2')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{3}=\z}
    end

    it 'replies in correct format' do
      send_command('randbase64  --length 3')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{4}\z}
    end

    it 'replies in correct format' do
      send_command('randomb64 --length 34')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{46}==\z}
    end

    # The most important test, because this variant of command is the shortest
    # and it will be used most frequently
    it 'replies in correct format' do
      send_command('randb64  -l  35')
      expect(replies.last).to match %r{\A[A-Za-z0-9+/]{47}=\z}
    end
  end
end
