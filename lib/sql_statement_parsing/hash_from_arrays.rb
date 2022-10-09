# frozen_string_literal: true

class HashFromArrays
  attr_reader :fields, :values

  IRRELEVANT_FIELDS = %(id created_at updated_at)

  def initialize(fields, values)
    @fields = fields
    @values = values
  end

  def hash
    {}.tap do |hash|
      fields.each_with_index do |item, index|
        next if IRRELEVANT_FIELDS.include? item

        hash.merge!(item => values[index])
      end
    end.sort_by { |key, _value| key }.to_h
  end
end
