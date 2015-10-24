describe Lita::Handlers::Random, lita_handler: true do
  it { is_expected.to route_command('sHuFfLe').to :route_shuffle }
  it { is_expected.to route_command('ShUfFlE   a').to :route_shuffle }
  it { is_expected.to route_command('sHUfFLe A,   b').to :route_shuffle }
  it { is_expected.to route_command('ShuFflE  a, B,  c').to :route_shuffle }
  it { is_expected.to route_command('shUFfLE 1').to :route_shuffle }
  it { is_expected.to route_command('SHuFfle   1, b').to :route_shuffle }
  it { is_expected.to route_command('shUffLe 1,   2, 3').to :route_shuffle }
  it { is_expected.to route_command('shufFlE 1,b,C').to :route_shuffle }
  it { is_expected.to route_command('sHuffle  1,2,3').to :route_shuffle }

  describe '/shuffle <array, ...>' do
    it 'replies in correct format' do
      send_command 'shuFFLe'
      expect(replies.last).to eq ''
    end

    it 'replies in correct format' do
      send_command 'sHufflE a'
      expect(replies.last).to eq 'a'
    end

    it 'replies in correct format' do
      send_command 'shuffle 1'
      expect(replies.last).to eq '1'
    end

    it 'replies in correct format' do
      send_command 'shuffle Foo, 1'
      expect(replies.last).to match(/^(Foo|1), (Foo|1)$/)
      expect(replies.last.split(',').map(&:strip)).to match_array %w(Foo 1)
    end

    it 'replies in correct format' do
      send_command 'SHUFFLE 123, a'
      expect(replies.last).to match(/^(123|a), (123|a)$/)
      expect(replies.last.split(',').map(&:strip)).to match_array %w(123 a)
    end

    it 'replies in correct format' do
      send_command 'ShUfFLe 1488,foObar'
      expect(replies.last).to match(/^(1488|foObar), (1488|foObar)$/)
      expect(replies.last.split(',').map(&:strip))
        .to match_array %w(1488 foObar)
    end
  end
end
