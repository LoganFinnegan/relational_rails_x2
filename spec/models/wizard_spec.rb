require 'rails_helper'

RSpec.describe Wizard, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :level}
    # it { should validate_inclusion_of(:graduated).in_array([true, false]) }
    it { should validate_presence_of :age}
  end

  describe 'relationships' do
    it {should have_many :spells}
  end

  describe 'instance methods' do
    it "#spell_count" do
      wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)

      spell_1 = wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)
      spell_2 = wizard_1.spells.create!(name: "haste", learned: true, spell_level: 3)

      expect(wizard_1.spell_count).to eq(2)
    end
  end

  describe 'class methods' do
    it "#sort_by_creation_date" do 
      wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
      wizard_2 = Wizard.create!(name: "Logan", level: 7, graduated: true, age: 211)

      expect(Wizard.sort_by_creation_date).to eq([wizard_2, wizard_1])
    end
  end
end