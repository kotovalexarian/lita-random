describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random').to :route_random }
  it { is_expected.to route_command('rand').to :route_random }
  it { is_expected.to route_command('RaNdOm').to :route_random }
  it { is_expected.to route_command('rAnD').to :route_random }

  it { is_expected.to route_command('random  5').to :route_random_to }
  it { is_expected.to route_command('rand   17').to :route_random_to }
  it { is_expected.to route_command('rAnDoM  59827').to :route_random_to }
  it { is_expected.to route_command('RanD  0').to :route_random_to }

  it { is_expected.to route_command('random  5.0').to :route_random_float_to }
  it { is_expected.to route_command('rand 17.74826').to :route_random_float_to }
  it { is_expected.to route_command('rAnDoM 5927.1').to :route_random_float_to }
  it { is_expected.to route_command('RanD  0.12397').to :route_random_float_to }

  it { is_expected.to route_command('random    0  1').to :route_random_from_to }
  it { is_expected.to route_command('rand 102  2695').to :route_random_from_to }
  it { is_expected.to route_command('rANdOM  1643 0').to :route_random_from_to }
  it { is_expected.to route_command('ranD  10   100').to :route_random_from_to }

  it do
    is_expected.to route_command('random  0   1.0')
      .to :route_random_float_from_to
  end

  it do
    is_expected.to route_command('rand 102.0  25')
      .to :route_random_float_from_to
  end

  it do
    is_expected.to route_command('rANdOM   13.1 0')
      .to :route_random_float_from_to
  end

  it do
    is_expected.to route_command('ranD 10   0.5')
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
      send_command('random 12 13.5')
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 12
      expect(value).to be < 13.5
    end

    it 'replies in correct format' do
      send_command('random 16.3 17')
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 16.3
      expect(value).to be < 17
    end

    it 'replies in correct format' do
      send_command('random 1.8 3.4')
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 1.8
      expect(value).to be < 3.4
    end
  end

  it { is_expected.to route_command('random  base64').to :route_random_base64 }
  it { is_expected.to route_command('rand  base64').to :route_random_base64 }
  it { is_expected.to route_command('rAnDoM bAsE64').to :route_random_base64 }
  it { is_expected.to route_command('RaNd   BaSe64').to :route_random_base64 }

  it { is_expected.to route_command('randombase64').to :route_random_base64 }
  it { is_expected.to route_command('randbase64').to :route_random_base64 }
  it { is_expected.to route_command('rAnDoMb64').to :route_random_base64 }
  it { is_expected.to route_command('RaNdB64').to :route_random_base64 }

  it do
    is_expected.to route_command('random  base64 0').to :route_random_base64_n
  end

  it do
    is_expected.to route_command('rand  base64  523').to :route_random_base64_n
  end

  it do
    is_expected.to route_command('rAnDoM bAsE64 5').to :route_random_base64_n
  end

  it do
    is_expected.to route_command('RaNd BaSe64   4925').to :route_random_base64_n
  end

  it do
    is_expected.to route_command('randombase64 0').to :route_random_base64_n
  end

  it { is_expected.to route_command('randbase64 23').to :route_random_base64_n }
  it { is_expected.to route_command('rAnDoMb64 5').to :route_random_base64_n }
  it { is_expected.to route_command('RaNdB64  4925').to :route_random_base64_n }

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
  end

  it { is_expected.to route_command('random  Hx').to :route_random_hex }
  it { is_expected.to route_command('rand  hex').to :route_random_hex }
  it { is_expected.to route_command('rAnDoM HeX').to :route_random_hex }
  it { is_expected.to route_command('RaNd   hx').to :route_random_hex }

  it { is_expected.to route_command('randomHx').to :route_random_hex }
  it { is_expected.to route_command('randhex').to :route_random_hex }
  it { is_expected.to route_command('rAnDoMx').to :route_random_hex }
  it { is_expected.to route_command('RaNdX').to :route_random_hex }

  it { is_expected.to route_command('random  hx  0').to :route_random_hex_n }
  it { is_expected.to route_command('rand  hEx 284').to :route_random_hex_n }
  it { is_expected.to route_command('rAnDoM HeX 1').to :route_random_hex_n }
  it { is_expected.to route_command('RaNd   Hx  4928').to :route_random_hex_n }

  it { is_expected.to route_command('randomhx  0').to :route_random_hex_n }
  it { is_expected.to route_command('randhEx 284').to :route_random_hex_n }
  it { is_expected.to route_command('rAnDoMx 1').to :route_random_hex_n }
  it { is_expected.to route_command('RaNdX  4928').to :route_random_hex_n }

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
  end

  it { is_expected.to route_command('random  uuid').to :route_random_uuid }
  it { is_expected.to route_command('rand  uUiD').to :route_random_uuid }
  it { is_expected.to route_command('rAnDoM uid').to :route_random_uuid }
  it { is_expected.to route_command('RaNd   UiD').to :route_random_uuid }

  it { is_expected.to route_command('randomuuid').to :route_random_uuid }
  it { is_expected.to route_command('randuUiD').to :route_random_uuid }
  it { is_expected.to route_command('rAnDoMuId').to :route_random_uuid }
  it { is_expected.to route_command('RaNdUiD').to :route_random_uuid }

  describe '/random uuid' do
    it 'replies in correct format' do
      send_command('random uuid')
      expect(replies.last)
        .to match(/\A[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}\z/)
    end
  end
end
