describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random  case').to :route_random_case }
  it { is_expected.to route_command('rand  case').to :route_random_case }
  it { is_expected.to route_command('rAnDoM cAsE').to :route_random_case }
  it { is_expected.to route_command('RaNd   CaSe').to :route_random_case }

  it { is_expected.to route_command('randomcase').to :route_random_case }
  it { is_expected.to route_command('randcase').to :route_random_case }
  it { is_expected.to route_command('rAnDoMcAsE').to :route_random_case }
  it { is_expected.to route_command('RaNdCaSe').to :route_random_case }

  describe '/random case <s>' do
    it 'replies in correct format' do
      send_command 'random case'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'RaNd CaSe'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'RaNdOmCaSe'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'rAnDcAsE'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'random case  1'
      expect(replies.last).to eq '1'
    end

    it 'replies in correct format' do
      send_command 'RaNd CaSe  foo'
      expect(replies.last).to match(/\Afoo\z/i)
    end

    it 'replies in correct format' do
      send_command 'RaNdOmCaSe foo  bar'
      expect(replies.last).to match(/\Afoo  bar\z/i)
    end

    it 'replies in correct format' do
      send_command 'rAnDcAsE  12345'
      expect(replies.last).to eq '12345'
    end
  end
end
