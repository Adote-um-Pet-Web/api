# frozen_string_literal: true

shared_examples 'paginatable concern' do |factory_name|
  context ' when records fit page size' do
    let!(:records) { create_list(factory_name, 35) }

    context 'when :page and :per are empty' do
      it 'returns the default number of records per page as defined by Kaminari' do
        paginated_records = described_class.page(nil).per(nil)
        expect(paginated_records.size).to eq(Kaminari.config.default_per_page)
      end

      it 'matches first default number of records as defined by Kaminari' do
        paginated_records = described_class.page(nil).per(nil)
        expected_records = described_class.all[0..(Kaminari.config.default_per_page - 1)]
        expect(paginated_records).to eq expected_records
      end
    end

    context 'when :page is fulfilled and :per is empty' do
      let(:page) { 2 }

      it 'returns default 10 records' do
        paginated_records = described_class.page(page).per(nil)
        expect(paginated_records.size).to eq 10
      end

      it 'returns 10 records from right page' do
        paginated_records = described_class.page(page).per(nil)
        first_record_index = (page - 1) * Kaminari.config.default_per_page
        last_record_index = first_record_index + 9
        expected_records = described_class.all[first_record_index..last_record_index]
        expect(paginated_records).to eq expected_records
      end
    end

    context 'when page and per are fulfilled and fits records size' do
      let(:page) { 2 }
      let(:per) { 5 }

      it 'returns right quantity of records' do
        paginated_records = described_class.page(page).per(per)
        expect(paginated_records.size).to eq per
      end

      it 'return records form right page' do
        paginated_records = described_class.page(page).per(per)
        first_record_index = (page - 1) * per
        last_record_index = first_record_index + (per - 1)
        expected_records = described_class.all[first_record_index..last_record_index]
        expect(paginated_records).to eq expected_records
      end
    end

    context 'when page and per are fulfilled and not fits records size' do
      let(:page) { 3 }
      let(:per) { 20 }

      it 'does not return any records' do
        paginated_records = described_class.page(page).per(per)
        expect(paginated_records.size).to eq 0
      end

      it 'returns empty result' do
        paginated_records = described_class.page(page).per(per)
        expect(paginated_records).to be_empty
      end
    end
  end
end
