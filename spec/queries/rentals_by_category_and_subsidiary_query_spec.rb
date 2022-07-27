# frozen_string_literal: true

require 'rails_helper'

describe RentalsByCategoryAndSubsidiaryQuery do
  it 'should return result filter by date' do
    paulista = create(:subsidiary, name: 'Paulista')
    paraiso  = create(:subsidiary, name: 'Paraiso')
    category_a = create(:category, name: 'A')
    category_b = create(:category, name: 'B')
    create_list(:rental, 2, category: category_a, subsidiary: paulista,
                            start_date: '01/01/3000', end_date: '03/01/3000')
    create_list(:rental, 3, category: category_b, subsidiary: paraiso,
                            start_date: '05/01/3000', end_date: '08/01/3000')
    create(:rental, category: category_b, subsidiary: paulista,
                    start_date: '02/01/3000', end_date: '05/01/3000')
    create(:rental, category: category_a, subsidiary: paraiso,
                    start_date: '02/02/3000', end_date: '05/02/3000')

    # Paulista { Category A: 2, Category B: 1 }
    # Paraiso  { Category A: 0, Category B: 3 }
    # [
    #   { subsidiary: 'Paraiso', category: 'B', total: 3 }
    #   { subsidiary: 'Paulista', category: 'A', total: 2 }
    #   { subsidiary: 'Paulista', category: 'B', total: 1 }
    # ]

    result = described_class.new('01/01/3000', '31/01/3000').call

    expect(result.count).to eq 3
    expect(result.first).to include('total' => 3)
    expect(result.first).to include('category' => 'B')
    expect(result.first).to include('subsidiary' => 'Paraiso')
    expect(result.second).to include('total' => 2)
    expect(result.second).to include('category' => 'A')
    expect(result.second).to include('subsidiary' => 'Paulista')
    expect(result.third).to include('total' => 1)
    expect(result.third).to include('category' => 'B')
    expect(result.third).to include('subsidiary' => 'Paulista')
  end
end
