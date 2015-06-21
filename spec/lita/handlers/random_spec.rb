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
end
