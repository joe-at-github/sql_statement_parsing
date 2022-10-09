# SqlStatementParsing

Abstraction layer allowing to turn SQL statements into Hash / YAML objects.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sql_statement

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sql_statement

## Usage
```ruby
# insert
sql = "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, '5')"

sql_statement = SqlStatementParsing::Object.new(sql)

sql_statement.hash
=> {"provider_id"=>"173", "quantity"=>nil, "reference"=>"5"}

sql_statement.yaml
=> "---\ninsert_products:\n  provider_id: '173'\n  quantity:\n  reference: '5'\n"

sql_statement.operation
=> "insert"

sql_statement.table_name
=> "products"

# update
sql = "UPDATE `providers` SET `provider_id` = 15935967, `updated_at` = '2022-07-28 09:34:00', `id` = 15436376, `status` = 'live' WHERE `providers`.`id` = 15436376"

sql_statement = SqlStatementParsing::Object.new(sql)

sql_statement.operation
=> "update"
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
Title of my commit describing what I have achieved

Actions:

+ description of main code change

+ description of other important code change

etc...

Motivations:

+ description of why main change is needed

+ description of wy other important change is needed

etc...

```