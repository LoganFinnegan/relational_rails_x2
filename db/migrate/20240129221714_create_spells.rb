class CreateSpells < ActiveRecord::Migration[7.0]
  def change
    create_table :spells do |t|
      t.string :name
      t.boolean :learned
      t.integer :spell_level
      t.references :wizard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
