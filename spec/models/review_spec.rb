require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :shelter }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:title) }
  end
end
