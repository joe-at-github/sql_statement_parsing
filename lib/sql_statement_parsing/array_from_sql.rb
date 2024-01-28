# frozen_string_literal: true

class ArrayFromSql
  attr_reader :sql_statement

  INSERT_KEYS_REGEX = /\((`.*)`\)/.freeze
  INSERT_VALUES_REGEX = /VALUES\s\((.*)\)/.freeze
  UPDATE_KEYS_REGEX = /SET.*WHERE/.freeze
  UPDATE_VALUES_REGEX = /SET(.*)WHERE/.freeze

  def initialize(sql_statement)
    @sql_statement = sql_statement
  end

  def table_name
    if insert_statement?
      sql_statement.match(/INSERT INTO `.*` /).to_s.match(/`(.*)`/)[1]
    elsif update_statement?
      sql_statement.match(/UPDATE `(.*)` SET/)[1]
    else
      raise 'statement type not detected in table_name'
    end
  rescue NoMethodError => e
    puts "Parsing error.Could not parse: "
    puts  sql_statement
  end

  def fields
    if insert_statement?
      sql_statement.match(INSERT_KEYS_REGEX)[1].split(',').map { |value| value.delete('`').strip }
    elsif update_statement?
      format_like_rails_5(sql_statement).match(UPDATE_KEYS_REGEX).to_s.scan(/`\w*`/).map do |value|
        value.gsub('`', '')
      end
    else
      raise 'statement type not detected in fields'
    end
  rescue NoMethodError => e
    puts "Parsing error.Could not parse: "
    puts  sql_statement
    []
  end

  def values
    if insert_statement?
      format_boolean_like_rails_5(sql_statement).match(INSERT_VALUES_REGEX)[1].gsub(/[aA-zZ](,)\s*[aA-zZ]/,
                                                                                    '..;..').split(',').map do |value|
        value.delete("'").strip
      end
    elsif update_statement?
      format_like_rails_5(sql_statement).match(UPDATE_VALUES_REGEX)[1].gsub(/`\w*` = /, '').gsub(
        /[aA-zZ](,)\s*[aA-zZ]/, '..;..'
      ).split(',').map do |value|
        value.delete("'").strip
      end
    else
      raise 'statement type not detected in values'
    end
  end

  def insert_statement?
    sql_statement.match('INSERT INTO').to_s != ''
  end

  def update_statement?
    sql_statement.match('UPDATE').to_s != ''
  end

  private

  def format_like_rails_5(string)
    # Remove extra wraping generated by Rails 6 and making it equal to a Rails 5 generate statement
    # SET `leads`.`contact_log_id` = 12227259
    # TO
    # SET `contact_log_id` = 12227259
    return string.gsub(/(`\w*`.)`/, '`') unless sql_statement.match(/(`\w*`.)`/).nil?

    string
  end

  def format_boolean_like_rails_5(string)
    string = string.gsub!('FALSE', '0') if string.match('FALSE')
    string = string.gsub!('TRUE', '1') if string.match('TRUE')
    string
  end
end
