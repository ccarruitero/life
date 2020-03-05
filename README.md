# Life
Conway's Game of Life ruby implementation

## Installation

In order to use the command line executable you have to clone repository, build
gem and install.

```
git clone https://github.com/ccarruitero/life.git
cd life && gem build life.gemspec
gem install life-0.1.0.gem
```

Alternative, if you want to use gem's internal logic (Ex: `Life::Game` or
 `Life::Cell`) in your project, add this line to your application's Gemfile:

```ruby
gem 'life', github: 'ccarruitero/life'
```

And then execute:

    $ bundle


## Usage
```
  life-cli new -h, --height=N -s, --seed-pattern=SEED_PATTERN -t, --pattern-type=PATTERN_TYPE -w, --width=N

Options:
  -h, --height=N
  -w, --width=N
  -s, --seed-pattern=SEED_PATTERN
  -t, --pattern-type=PATTERN_TYPE  # Possible values: numeric, array
```

For example, this will generate a 10 x 10 grid and seed every 5 cell

```
life-cli new -h 10 -w 10 -s 5 -t numeric

```

And this will generate a 10 x 10 grid and seed only given positions
```
life-cli new -h 10 -w 10 -s [[3,5],[3,2],[1,1],[1,2],[1,3]] -t array
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ccarruitero/life.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
