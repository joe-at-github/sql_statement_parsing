# frozen_string_literal: true

require File.expand_path(File.join('..', '..', 'lib', 'sql_statement_parsing'), __dir__)

# rubocop:disable Metrics/BlockLength
RSpec.describe SqlStatementParsing::SqlStatement do
  subject(:sql_statement) { described_class.new(sql_string) }

  let(:sql_string) do
    "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, 'HJIK4', '5')"
  end

  describe '#to_h' do
    let(:expectation) do
      {
        metadata: { operation: 'insert', table: 'products' },
        data: { 'provider_id' => '173', 'quantity' => '5', 'reference' => 'HJIK4',
                'created_at' => '2022-07-28 14:57:15', 'updated_at' => '2022-07-28 14:57:15' },
        statement: sql_string
      }
    end

    it 'generates a hash' do
      expect(sql_statement.to_h).to eq expectation
    end
  end

  describe '#table' do
    let(:expectation) { 'products' }

    it 'returns the table name' do
      expect(sql_statement.table).to eq expectation
    end
  end

  describe '#data' do
    let(:expectation) do
      {
        'provider_id' => '173',
        'quantity' => '5',
        'reference' => 'HJIK4',
        'created_at' => '2022-07-28 14:57:15',
        'updated_at' => '2022-07-28 14:57:15'
      }
    end

    it 'returns the data section' do
      expect(sql_statement.data).to eq expectation
    end
  end

  describe '#statement' do
    it 'returns the data section' do
      expect(sql_statement.statement).to eq sql_string
    end
  end

  describe '#operation' do
    context 'insert' do
      let(:sql_string) do
        "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, 'HJIK4', '5')"
      end
      let(:expectation) { 'insert' }

      it 'returns the name of the sql operation' do
        expect(sql_statement.operation).to eq expectation
      end
    end

    context 'update' do
      let(:sql_string) do
        "UPDATE `providers` SET `provider_id` = 15935967, `updated_at` = '2022-07-28 09:34:00', `id` = 15436376, `status` = 'live' WHERE `providers`.`id` = 15436376"
      end
      let(:expectation) { 'update' }

      it 'returns the name of the sql operation' do
        expect(sql_statement.operation).to eq expectation
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
