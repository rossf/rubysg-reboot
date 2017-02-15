require 'rails_helper'

RSpec.describe Company do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :website }
    it { is_expected.to validate_presence_of :logo_url }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :email }
  end

  describe '.all' do
    let(:company_a) { double(:company_a, name: 'xyz') }
    let(:company_b) { double(:company_b, name: 'abc') }
    let(:company_c) { double(:company_c, name: 'MNO') }

    it 'sorts by name (ignore case)' do
      expect(RubysgReboot::COMPANIES).to receive(:map) { [company_a, company_b, company_c] }

      expect(Company.all).to eq [company_b, company_c, company_a]
    end
  end

  context 'validates company list' do
    it 'has valid companies' do
      Company.all.each do |company|
        expect(company).to be_valid, "#{company.name} is invalid: #{company.errors.full_messages}"
      end
    end
  end

  describe '#supporter?' do
    let(:company) { Company.new(contribution_count: contribution_count) }

    context 'with a supporting company' do
      let(:contribution_count) { 2 }

      it { expect(company.supporter?).to be_truthy }
    end

    context 'with a non-supporting company' do
      let(:contribution_count) { 1 }

      it { expect(company.supporter?).to be_falsey }
    end
  end
end
