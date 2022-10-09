# frozen_string_literal: true

require_relative 'sql_statement_parsing/version'
require_relative 'sql_statement_parsing/array_from_sql'
require_relative 'sql_statement_parsing/hash_from_arrays'

module SqlStatementParsing
  require 'yaml'

  class Error < StandardError; end

  class Object
    attr_reader :array_from_sql

    def initialize(sql_statement_string)
      @array_from_sql = ArrayFromSql.new(sql_statement_string)
    end

    def hash(prefix: false)
      object = HashFromArrays.new(fields, values).hash
      return object unless prefix

      { "#{operation}_#{table_name}" => object }
    end

    def yaml
      hash(prefix: true).to_yaml
    end

    def table_name
      array_from_sql.table_name
    end

    def operation
      return 'insert' if array_from_sql.insert_statement?
      return 'update' if array_from_sql.update_statement?

      'unkown_operation'
    end

    private

    def fields
      array_from_sql.fields
    end

    def values
      array_from_sql.values
    end
  end
end
