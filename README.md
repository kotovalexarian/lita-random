Lita::Handlers::Random
======================

[![Gem Version](https://badge.fury.io/rb/lita-random.svg)](http://badge.fury.io/rb/lita-random)
[![Build Status](https://travis-ci.org/braiden-vasco/lita-random.svg)](https://travis-ci.org/braiden-vasco/lita-random)
[![Coverage Status](https://coveralls.io/repos/braiden-vasco/lita-random/badge.svg)](https://coveralls.io/r/braiden-vasco/lita-random)

Generator of random numbers and strings for the Lita chat bot.

Usage
-----

At first, see the documentation for Lita: https://docs.lita.io/

### Installation

Add **lita-random** to your Lita instance's Gemfile:

```ruby
gem 'lita-random', '~> 0.1.0'
```

### Commands

- `random` -
  random float number, greater or equal to 0 and lesser than 1

- `random <to>` -
  random integer number, greater or equal to 0 and lesser than `to`

- `random <from> <to>` -
  random integer number, greater or equal to `from` and lesser than `to`

Command `random` has alias `rand`

### Examples

```
You: lita random
Lita: 0.52693215290866
You: lita rand
Lita: 0.8332672468501509
You: lita random 5
Lita: 2
You: lita rand 100
Lita: 24
You: lita random 5 10
Lita: 8
You: lita rand 1000 2000
Lita: 1240
```
