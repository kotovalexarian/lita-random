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
    class Random < Handler
      route(/^rand(om)?$/i, command: true) do |response|
        response.reply(::Random.rand.to_s)
      end

      route(/^rand(om)?\s+(\d+)?$/i, command: true) do |response|
        to = response.matches[0][1].to_i
        response.reply(::Random.rand(to).to_s)
      end

      route(/^rand(om)?\s+(\d+)\s+(\d+)?$/i, command: true) do |response|
        from = response.matches[0][1].to_i
        to = response.matches[0][2].to_i
        response.reply(::Random.rand(from...to).to_s)
      end
    end

    Lita.register_handler(Random)
  end
end
