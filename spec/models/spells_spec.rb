require 'rails_helper'

RSpec.describe Spell, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    # it { should validate_inclusion_of(:learned).in_array([true, false]) }
    it { should validate_presence_of :spell_level}
  end

  describe 'relationships' do
    it {should belong_to :wizard}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do
    it "#alphebetize" do
      wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
      
      spell_2 = wizard_1.spells.create!(name: "haste", learned: true, spell_level: 5)
      spell_1 = wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)

      expect(Spell.alphebetize).to eq([spell_1, spell_2])
    end

    it "#level_over" do
      wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
      
      spell_2 = wizard_1.spells.create!(name: "haste", learned: true, spell_level: 5)
      spell_1 = wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)

      expect(Spell.level_over(4)).to eq([spell_2])
    end
  end
end