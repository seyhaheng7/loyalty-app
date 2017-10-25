describe Customer, 'Validation' do
  it { is_expected.to validate_presence_of(:phone) }

  context 'Phone Format' do
    it 'invalid when has charactor' do
      customer = build(:customer, phone: '9843064a')
      expect(customer).to be_invalid
    end

    it 'invalid when length not 8 or 9' do
      customer = build(:customer, phone: '123')
      expect(customer).to be_invalid
    end

    it 'valid when length is 8' do
      customer = build(:customer, phone: '098430641')
      expect(customer).to be_valid
    end

    it 'valid when length is 9' do
      customer = build(:customer, phone: '0984306419')
      expect(customer).to be_valid
    end
  end
end
