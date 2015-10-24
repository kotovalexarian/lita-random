describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('random').to :route_random }
  it { is_expected.to route_command('rand').to :route_random }
  it { is_expected.to route_command('RaNdOm').to :route_random }
  it { is_expected.to route_command('rAnD').to :route_random }

  it { is_expected.to route_command('random  5').to :route_random }
  it { is_expected.to route_command('rand   17').to :route_random }
  it { is_expected.to route_command('rAnDoM  59827').to :route_random }
  it { is_expected.to route_command('RanD  0').to :route_random }

  it { is_expected.to route_command('random  5.0').to :route_random }
  it { is_expected.to route_command('rand 17.74826').to :route_random }
  it { is_expected.to route_command('rAnDoM 5927.1').to :route_random }
  it { is_expected.to route_command('RanD  0.12397').to :route_random }

  it { is_expected.to route_command('random    0  1').to :route_random }
  it { is_expected.to route_command('rand 102  2695').to :route_random }
  it { is_expected.to route_command('rANdOM  1643 0').to :route_random }
  it { is_expected.to route_command('ranD  10   100').to :route_random }

  it { is_expected.to route_command('random  0   1.0').to :route_random }
  it { is_expected.to route_command('rand 102.0  25').to :route_random }
  it { is_expected.to route_command('rANdOM   13.1 0').to :route_random }
  it { is_expected.to route_command('ranD 10   0.5').to :route_random }

  it { is_expected.to route_command('random  --to 5').to :route_random }
  it { is_expected.to route_command('rand -t  17').to :route_random }
  it { is_expected.to route_command('rAnDoM -t 59827').to :route_random }
  it { is_expected.to route_command('RanD  --to  0').to :route_random }

  it { is_expected.to route_command('random  -t 5.0').to :route_random }
  it { is_expected.to route_command('rand --to 17.74826').to :route_random }
  it { is_expected.to route_command('rAnDoM  -t 5927.1').to :route_random }
  it { is_expected.to route_command('RanD --to  0.12397').to :route_random }

  it { is_expected.to route_command('random --from  0 -to 1').to :route_random }
  it { is_expected.to route_command('rand -f 102 --to  2695').to :route_random }
  it { is_expected.to route_command('rANdOM  -f  1643 -t  0').to :route_random }
  it { is_expected.to route_command('ranD --from  10 -t 100').to :route_random }

  it { is_expected.to route_command('random --from 0 -t 1.0').to :route_random }
  it { is_expected.to route_command('rand  -f  102.0 -to 25').to :route_random }
  it { is_expected.to route_command('rANdOM -f 13.1 -t 0').to :route_random }
  it { is_expected.to route_command('ranD --from 1 --to 0.5').to :route_random }

  it do
    is_expected.not_to route_command('rand smart pass 10 --length 8')
      .to :route_random
  end

  describe '/random' do
    it 'replies in correct format' do
      send_command 'random'
      expect(replies.last).to match(/\A\d\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 0
      expect(value).to be < 1
    end
  end

  describe '/random <to>' do
    it 'replies in correct format' do
      send_command 'random 1'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random --to 1'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random -t 1'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random 20'
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < 20
    end

    it 'replies in correct format' do
      send_command 'random  -t  20'
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < 20
    end

    it 'doesn\'t reply if both positional and keyword arguments present' do
      send_command 'random 2 --to 10'
      expect(replies).to be_empty
    end
  end

  describe '/random <to:float>' do
    it 'replies in correct format' do
      send_command 'random 1.0'
      expect(replies.last).to match(/\A\d\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 0
      expect(value).to be < 1
    end

    it 'replies in correct format' do
      send_command 'random --to 1.0'
      expect(replies.last).to match(/\A\d\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 0
      expect(value).to be < 1
    end

    it 'replies in correct format' do
      send_command 'random -t 1.0'
      expect(replies.last).to match(/\A\d\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 0
      expect(value).to be < 1
    end

    it 'replies in correct format' do
      send_command 'random 20.0'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < 20
    end

    it 'replies in correct format' do
      send_command 'random  --to  20.0'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < 20
    end

    it 'doesn\'t reply if both positional and keyword arguments present' do
      send_command 'random 2.0 --to 10.0'
      expect(replies).to be_empty
    end
  end

  describe '/random <from> <to>' do
    it 'replies in correct format' do
      send_command 'random 0 1'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random 1 -f 0'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random 1 --from 0'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random --to 1 --from 0'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random -t 1 -f 0'
      expect(replies.last).to eq '0'
    end

    it 'replies in correct format' do
      send_command 'random 0 20'
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < 20
    end

    it 'replies in correct format' do
      send_command 'random 20  --from 0'
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 0
      expect(value).to be < 20
    end

    it 'replies in correct format' do
      send_command 'random 10010 -f 10000'
      expect(replies.last).to match(/\A\d+\z/)
      value = replies.last.to_i
      expect(value).to be >= 10_000
      expect(value).to be < 10_010
    end

    it 'doesn\'t reply if both positional and keyword arguments present' do
      send_command 'random 10 --from 2 --to 10'
      expect(replies).to be_empty
    end
  end

  describe '/random <from:float> <to:float>' do
    it 'replies in correct format' do
      send_command 'random 12 13.5'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 12
      expect(value).to be < 13.5
    end

    it 'replies in correct format' do
      send_command 'random 16.3 17'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 16.3
      expect(value).to be < 17
    end

    it 'replies in correct format' do
      send_command 'random 1.8 3.4'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 1.8
      expect(value).to be < 3.4
    end

    it 'replies in correct format' do
      send_command 'random 13.5  -f  12'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 12
      expect(value).to be < 13.5
    end

    it 'replies in correct format' do
      send_command 'random 17  --from 16.3'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 16.3
      expect(value).to be < 17
    end

    it 'replies in correct format' do
      send_command 'random  --to  3.4 -f  1.8'
      expect(replies.last).to match(/\A\d+\.\d+\z/)
      value = replies.last.to_f
      expect(value).to be >= 1.8
      expect(value).to be < 3.4
    end

    it 'doesn\'t reply if both positional and keyword arguments present' do
      send_command 'random 10.0 --from 2.0 --to 10.0'
      expect(replies).to be_empty
    end
  end
end
