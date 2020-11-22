RSpec.describe Product, type: :model do
  it {
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_presence_of(:price)
    is_expected.to validate_presence_of(:category)
    is_expected.to validate_presence_of(:email)
  }

  describe '.email' do
    subject { FactoryBot.build(:product, email: email) }

    context 'when valid' do
      let(:email) { 'sample@mail.com' }

      it 'returns valid' do
        expect(subject).to be_valid
      end
    end

    context 'when invalid' do
      let(:email) { 'samplemail.com' }

      it 'returns invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end