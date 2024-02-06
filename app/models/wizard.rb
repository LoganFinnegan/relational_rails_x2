class Wizard < ApplicationRecord
  validates_presence_of :name,
                        :level,
                        :age

  validates_inclusion_of :graduated, :in => [true, false]

  has_many :spells, dependent: :destroy

  def self.sort_by_creation_date
    order(created_at: :desc)
  end

  def spell_count
    spells.count
  end
end
