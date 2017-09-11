# `DidYou::Spell` -- small wrapper around `did_you_mean`

Have you seen this thing in new Ruby (2.3+)?

```ruby
(1..10).cover(2)
# NoMethodError: undefined method `cover' for 1..10:Range
# Did you mean?  cover?  <---- This
```

If you wanted to provide same functionality for your code ("Lexem `x` is not recognized. Did you
mean `y`?") you can use [did_you_mean](https://github.com/yuki24/did_you_mean) gem bundled with
your Ruby. But it is a bit hard: gem's dictionary lookup interface is a bit hard to follow, and
moreover, it changes dramatically from Ruby 2.3 to Ruby 2.4, and standalone gem version (available
for Ruby 2.1-2.2) has one more different interface.

`did_you` solves this problem by providing simple, Ruby version-agnostic inteface to `did_you_mean`
gem.

## Usage

Install it as a `gem did_you` or add `gem 'did_you'` to your `Gemfile`. (On Ruby < 2.3 it will install
old `did_you_mean`, on newer ones has no additional dependencies.)

Then just...

```ruby
# First parameter is word you want to check, second -- known words in the context
DidYou::Spell.check('params', %w[param return tag abstract]) # => ["param"]
```

That's it. ¯\\\_(ツ)_/¯

## Author

[Victor Shepelev](https://github.com/zverok)

## License

MIT
