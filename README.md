# SqlStatementParsing

A domain object that allows extracting meaningful data from SQL statements.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sql_statement

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sql_statement

## Usage
Instantiation
```ruby
sql = "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, HJIK4, '7')"

sql_statement = SqlStatementParsing::SqlStatement.new(sql)
```

Methods
```ruby
sql_statement.operation
=> "insert"

sql_statement.table
=> "products"

sql_statement.data
=> { 'provider_id' => '173', 'quantity' => '7', 'reference' => 'HJIK4', 'created_at' => '2022-07-28 14:57:15', 'updated_at' => '2022-07-28 14:57:15' }

sql_statement.statement
=> "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, HJIK4, '7')"

sql_statement.to_h
=>  {
      metadata: { operation: 'insert', table: 'products' },
      data: {
        'provider_id' => '173',
        'quantity' => '7',
        'reference' => 'HJIK4',
        'created_at' => '2022-07-28 14:57:15',
        'updated_at' => '2022-07-28 14:57:15'
      },
      statement: "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, HJIK4, '7')"
    }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

### Bug reports
Bug reports and pull requests are welcome on GitHub at https://github.com/joe-at-github/sql_statement.


### Pull requests
- add / refactor feature in lib folder
- add spec
- bump patch version
- use the git message template below

```bash
Commit describing what has been achieved.

Actions:

+ Description of main code change.

+ Description of other important code change.

etc...

Motivations:

+ Description of why main change is needed.

+ Description of why other important change is needed.

etc...

```