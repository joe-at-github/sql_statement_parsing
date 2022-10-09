# frozen_string_literal: true

require File.expand_path(File.join('..', '..', 'lib', 'sql_statement_parsing'), __dir__)

RSpec.describe SqlStatementParsing::Object do
  describe '#hash' do
    subject(:sql_statement) { described_class.new(sql_string).hash }
    let(:sql_string) do
      "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, '5')"
    end
    let(:expectation) { { 'provider_id' => '173', 'quantity' => nil, 'reference' => '5' } }

    it 'generates a hash' do
      expect(sql_statement).to eq expectation
    end
  end

  describe '#yaml' do
    subject(:sql_statement) { described_class.new(sql_string).yaml }
    let(:sql_string) do
      "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, '5')"
    end
    let(:expectation) { "---\ninsert_products:\n  provider_id: '173'\n  quantity: \n  reference: '5'\n" }

    it 'generates YAML' do
      expect(sql_statement).to eq expectation
    end
  end

  describe '#table_name' do
    subject(:sql_statement) { described_class.new(sql_string).table_name }
    let(:sql_string) do
      "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, '5')"
    end
    let(:expectation) { 'products' }

    it 'returns the table name' do
      expect(sql_statement).to eq expectation
    end
  end

  describe '#operation' do
    subject(:sql_statement) { described_class.new(sql_string).operation }

    context 'insert' do
      let(:sql_string) do
        "INSERT INTO `products` (`created_at`, `updated_at`, `provider_id`, `reference`, `quantity`) VALUES ('2022-07-28 14:57:15', '2022-07-28 14:57:15', 173, '5')"
      end
      let(:expectation) { 'insert' }

      it 'returns the name of the sql operation' do
        expect(sql_statement).to eq expectation
      end
    end

    context 'update' do
      let(:sql_string) do
        "UPDATE `providers` SET `provider_id` = 15935967, `updated_at` = '2022-07-28 09:34:00', `id` = 15436376, `status` = 'live' WHERE `providers`.`id` = 15436376"
      end
      let(:expectation) { 'update' }

      it 'returns the name of the sql operation' do
        expect(sql_statement).to eq expectation
      end
    end
  end
end
