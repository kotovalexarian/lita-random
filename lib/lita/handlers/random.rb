##
# Lita module.
#
module Lita
  ##
  # Lita handlers module.
  #
  module Handlers
    ##
    # Generator of random numbers and strings for the Lita chat bot.
    #
    class Random < Handler # rubocop:disable Metrics/ClassLength
      HELP = {
        'random' =>
          'random float number, greater or equal to 0 and lesser than 1',

        'random <to>' =>
          'random integer or float number, ' \
          'greater or equal to 0 and lesser than `to`',

        'random <from> <to>' =>
          'random integer or float number, ' \
          'greater or equal to `from` and lesser than `to`',

        'random base64 <n=16>' =>
          'random base64 string, length of source string is n, ' \
          'length of result is about `n * 4 / 3` ' \
          '(24 with default value of `n`)',

        'random hex <n=16>' =>
          'random hexadecimal string with length `n * 2`',

        'random uuid' =>
          'v4 random UUID (Universally Unique IDentifier). ' \
          'The version 4 UUID is purely random (except the version). ' \
          'It doesn’t contain meaningful information ' \
          'such as MAC address, time, etc.',

        'random password <n=16>' =>
          'random password with length `n` containing characters ' \
          'in upper and lower case, and digits',

        'random smart password <n=8>' =>
          'random pronounceable password with a minimum length of `n`',

        'shuffle <array, ...>' =>
          'new array with elements of `array` shuffled',

        'sample <n=1> <array, ...>' =>
          'choose `n` random elements from `array`',
      }

      route(/^rand(om)?$/i, :route_random, command: true, help: HELP)
      def route_random(response)
        response.reply(::Random.rand.to_s)
      end

      route(/^rand(om)?\s+(\d+)?$/i, :route_random_to, command: true)
      def route_random_to(response)
        to = response.matches[0][1].to_i
        response.reply(::Random.rand(to).to_s)
      end

      route(/^rand(om)?\s+(\d+\.\d+)?$/i, :route_random_float_to, command: true)
      def route_random_float_to(response)
        to = response.matches[0][1].to_f
        response.reply(::Random.rand(to).to_s)
      end

      route(/^rand(om)?\s+(\d+)\s+(\d+)?$/i,
            :route_random_from_to, command: true)
      def route_random_from_to(response)
        from = response.matches[0][1].to_i
        to = response.matches[0][2].to_i
        response.reply(::Random.rand(from...to).to_s)
      end

      route(/^rand(om)?\s+(?<from>\d+\.\d+)\s+(?<to>\d+)?$/i,
            :route_random_float_from_to, command: true)
      route(/^rand(om)?\s+(?<from>\d+(\.\d+)?)\s+(?<to>\d+\.\d+)?$/i,
            :route_random_float_from_to, command: true)
      def route_random_float_from_to(response)
        matches = response.matches[0]
        from = matches[0].to_f
        to = matches[1].to_f
        response.reply(::Random.rand(from...to).to_s)
      end

      route(/^rand(om)?\s*b(ase)?64$/i, :route_random_base64, command: true)
      def route_random_base64(response)
        response.reply(SecureRandom.base64)
      end

      route(/^rand(om)?\s*b(ase)?64\s+(?<n>\d+)$/i,
            :route_random_base64_n, command: true)
      def route_random_base64_n(response)
        n = response.matches[0][0].to_i
        response.reply(SecureRandom.base64(n))
      end

      route(/^rand(om)?\s*(he?)?x$/i, :route_random_hex, command: true)
      def route_random_hex(response)
        response.reply(SecureRandom.hex)
      end

      route(/^rand(om)?\s*(he?)?x\s+(?<n>\d+)$/i,
            :route_random_hex_n, command: true)
      def route_random_hex_n(response)
        n = response.matches[0][0].to_i
        response.reply(SecureRandom.hex(n))
      end

      route(/^rand(om)?\s*u?uid$/i, :route_random_uuid, command: true)
      def route_random_uuid(response)
        response.reply(SecureRandom.uuid)
      end

      route(/^rand(om)?\s*smart\s*pass(word)?$/i,
            :route_random_smart_pass, command: true)
      def route_random_smart_pass(response)
        response.reply(smart_password)
      end

      route(/^rand(om)?\s*smart\s*pass(word)?\s+(?<n>\d+)$/i,
            :route_random_smart_pass_n, command: true)
      def route_random_smart_pass_n(response)
        min_length = response.matches[0][0].to_i
        response.reply(smart_password(min_length))
      end

      route(/^rand(om)?\s*pass(word)?$/i, :route_random_pass, command: true)
      def route_random_pass(response)
        response.reply(password)
      end

      route(/^rand(om)?\s*pass(word)?\s+(?<n>\d+)$/i,
            :route_random_pass_n, command: true)
      def route_random_pass_n(response)
        length = response.matches[0][0].to_i
        response.reply(password(length))
      end

      route(/^shuffle(\s+(?<array>.*))?$/i, :route_shuffle, command: true)
      def route_shuffle(response)
        s = response.matches[0][0]
        a = s ? s.split(',').map(&:strip) : []
        response.reply(a.shuffle.join(', '))
      end

      route(/^sample(\s+((?<n>\d+)\s+)?(?<array>.*))?$/i,
            :route_sample, command: true)
      def route_sample(response)
        matches = response.matches[0]
        n = matches[0]
        s = matches[1]
        a = s ? s.split(',').map(&:strip) : []
        result = n ? a.sample(n.to_i).join(', ') : a.sample.to_s
        response.reply(result)
      end

    protected

      SMART_PASS_SEQS = {
        false => %w(
          b c d f g h j k l m n p qu r s t v w x z
          ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr lt
        ),
        true => %w(a e i o u y),
      }

      def smart_password(min_length = 8)
        password = ''
        sequence_id = false
        while password.length < min_length
          sequence = SMART_PASS_SEQS[sequence_id]
          password << sequence.sample
          sequence_id = !sequence_id
        end
        password
      end

      PASS_CHARS = [*'a'..'z', *'A'..'Z', *'0'..'9']

      def password(length = 16)
        (0...length).map { |_| PASS_CHARS.sample }.join
      end
    end

    Lita.register_handler(Random)
  end
end
