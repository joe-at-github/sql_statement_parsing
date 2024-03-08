# frozen_string_literal: true

require_relative 'sql_statement_parsing/version'
require_relative 'sql_statement_parsing/sql_string'

module SqlStatementParsing
  class Error < StandardError; end

  # Main abstraction layer providing a public interface to access data contained in the SQL statement.
  class SqlStatement
    attr_reader :sql_string

    def initialize(sql_statement_string)
      @sql_string = SqlString.new(sql_statement_string)
    end

    def to_h
      {
        metadata: metadata,
        data: data,
        statement: statement
      }
    end

    def data
      return {} if sql_string.fields.empty?

      key_values.sort_by { |key, _value| key }.to_h
    end

    def statement
      sql_string.sql_statement
    end

    def table
      sql_string.table_name
    end

    def operation
      return 'insert' if sql_string.insert_statement?
      return 'update' if sql_string.update_statement?

      'unkown_operation'
    end

    private

    def metadata
      { operation: operation, table: table }
    end

    def key_values
      {}.tap do |hash|
        sql_string.fields.each_with_index do |item, index|
          hash.merge!(item.to_sym => sql_string.values[index])
        end
      end
    end
  end
end
