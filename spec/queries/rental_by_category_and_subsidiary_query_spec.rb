# frozen_string_literal: true

describe RentalByCategoryAndSubsidiaryQuery do
  it 'should return result filtered by date' do
    paulista = create(:subsidiary, name: 'Paulista')
    paraiso = create(:subsidiary, name: 'Paraiso')
    category_a = create(:category, name: 'A')
    category_b = create(:category, name: 'B')
    allow_any_instance_of(Rental).to receive(:cars_available)
    create_list(:rental, 2, category: category_a, subsidiary: paulista,
                start_date: 10.days.from_now, end_date: 15.days.from_now)
    create_list(:rental, 3, category: category_b, subsidiary: paraiso,
                start_date: 11.days.from_now, end_date: 13.days.from_now)
    create_list(:rental, 2, category: category_a, subsidiary: paraiso,
                start_date: 11.days.from_now, end_date: 13.days.from_now)
    create(:rental, category: category_a, subsidiary: paulista,
           start_date: 5.days.from_now, end_date: 6.days.from_now)

    result = described_class.new(start_date: 10.days.from_now, end_date: 15.days.from_now).call

    # [
    #   { subsidiary: 'Paraiso', category: 'B', total: 3 },
    #   { subsidiary: 'Paulista', category: 'A', total: 2 },
    #   { subsidiary: 'Paraiso', category: 'A', total: 2 }
    # ]
    expect(result.count).to eq(3)
    expect(result.first.symbolize_keys!).to include(subsidiary: 'Paraiso', category: 'B', total: 3)
    expect(result.second.symbolize_keys!).to include(subsidiary: 'Paraiso', category: 'A', total: 2)
    expect(result.third.symbolize_keys!).to include(subsidiary: 'Paulista', category: 'A', total: 2)
  end
end
