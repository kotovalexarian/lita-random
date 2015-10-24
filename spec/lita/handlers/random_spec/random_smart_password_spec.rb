describe Lita::Handlers::Random, lita_handler: true do
  it do
    is_expected.to route_command('random smart password')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('RaNdOmSmArT PaSs')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rAnDoM SmArTpAsSwOrD')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('randomsmartpass')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rANd SMarT paSS')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('randsmart password')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rand smartpass')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('RanDSmaRTpAsSwORd')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('random smart password 0')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('RaNdOmSmArT PaSs   0')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rAnDoM SmArTpAsSwOrD 16482')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('randomsmartpass   1')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rANd SMarT paSS 148')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('randsmart password   0')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rand smartpass 1')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('RanDSmaRTpAsSwORd   137')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('random smart password -l 0')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('RaNdOmSmArT PaSs --length  0')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rAnDoM SmArTpAsSwOrD -l 16482')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('randomsmartpass -l  1')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rANd SMarT paSS --length 148')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('randsmart password  --length 0')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('rand smartpass -l 1')
      .to :route_random_smart_pass
  end

  it do
    is_expected.to route_command('RanDSmaRTpAsSwORd --length  137')
      .to :route_random_smart_pass
  end

  describe '/random smart password' do
    it 'replies in correct format' do
      send_command('random smart password')
      expect(replies.last).to match(/\A[a-z]{8,9}\z/)
    end
  end

  describe '/random smart password <length>' do
    it 'replies in correct format' do
      send_command('rAndoM sMarT pAssWorD 0')
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command('raNdsMaRTpasS 1')
      expect(replies.last).to match(/\A[a-z]{1,2}\z/)
    end

    it 'replies in correct format' do
      send_command('rand smart pass 2')
      expect(replies.last).to match(/\A[a-z]{2}\z/)
    end

    it 'replies in correct format' do
      send_command('randomsmartpassword 3')
      expect(replies.last).to match(/\A[a-z]{3,4}\z/)
    end

    it 'replies in correct format' do
      send_command('randomsmart password 4')
      expect(replies.last).to match(/\A[a-z]{4,5}\z/)
    end

    it 'replies in correct format' do
      send_command('random smartpass 16')
      expect(replies.last).to match(/\A[a-z]{16,17}\z/)
    end

    it 'replies in correct format' do
      send_command('random smartpass -l 16')
      expect(replies.last).to match(/\A[a-z]{16,17}\z/)
    end

    it 'replies in correct format' do
      send_command('random smartpass --length 16')
      expect(replies.last).to match(/\A[a-z]{16,17}\z/)
    end

    it 'doesn\'t reply if both positional and keyword arguments present' do
      send_command 'rand smart pass 10 --length 8'
      expect(replies).to be_empty
    end
  end
end
