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
gem 'lita-random', '~> 0.2.0'
```

### Commands

The space between instructions can be skiiped, so you can write
`random hex` as `randomhex`, `rand b64` as `randb64`

Command `random` has alias `rand`

* `random` -
  random float number, greater or equal to 0 and lesser than 1

* `random <to>` -
  random integer or float number, greater or equal to 0 and lesser than `to`

* `random <from> <to>` -
  random integer or float number, greater or equal to `from` and lesser than `to`

Command `base64` has alias `b64`

* `random base64` -
  random base64 string; length of source string is 16; length of result is 24

* `random base64 <n>` -
  random base64 string; length of source string is `n`;
  length of result is about 4/3 `n`

Command `hex` has alias `x`

* `random hex` -
  random hexadecimal string with length 32

* `random hex <n>` -
  random hexadecimal string with length `n * 2`

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

You: lita random 1.5
Lita: 1.1828046952104034
You: lita random 5 10
Lita: 8
You: lita rand 1000 2000
Lita: 1240
You: lita random 12 13.5
Lita: 13.458799783677263

You: lita random base64
Lite: 56wnZVVVStKG5+I6L4LVGw==
You: lita randb64 10
Lita: NMkIhB+iG2VNpg==

You: lita random hex
Lita: 7d6f39cf53303db862bac5e1b36eb0fa
You: lita randx 10
Lita: 0d8297837d6e63b8c25b
```
