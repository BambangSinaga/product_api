RSpec.describe Product, type: :model do
  it {
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_presence_of(:price)
    is_expected.to validate_presence_of(:category)
    is_expected.to validate_presence_of(:email)
  }
end