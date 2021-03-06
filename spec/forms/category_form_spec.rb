require 'rails_helper'

RSpec.describe CategoryForm, type: :model do
  let(:i18n_scope) { %i[activemodel errors models category attributes] }

  let(:valid_attributes) do
    { category: { name: 'My Category' } }
  end

  let(:form) { CategoryForm.new(Category.new) }

  describe 'model validations rules' do
    subject { form }

    before { create(:category, name: 'Category1') }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to_not allow_value('Category1').for(:name) }
    it { is_expected.to allow_value('Category2').for(:name) }
  end

  describe '#validate?' do
    subject! { form.validate(attributes) }

    context 'with correct attribute' do
      let(:attributes) { valid_attributes[:category] }

      it { is_expected.to be true }
    end

    context 'with empty name attribute' do
      let(:attributes) { valid_attributes[:category].merge!(name: nil) }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(form.errors[:name]).to eq [t('name.blank', scope: i18n_scope)]
      end
    end
  end
end
