class Spell < ApplicationRecord
  validates_presence_of :name,
                        :spell_level

  validates_inclusion_of :learned, :in => [true, false]
  
  belongs_to :wizard

  def self.learned_spells 
    self.where(learned: true)
  end

  def self.alphebetize
    order(:name)
  end

  def self.level_over(threshold)
    where("spell_level >= ?", threshold) 
  end
end