describe Lita::Handlers::Random, lita_handler: true do
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
