class CreateWizards < ActiveRecord::Migration[7.0]
  def change
    create_table :wizards do |t|
      t.string :name
      t.integer :level
      t.boolean :graduated
      t.integer :age

      t.timestamps
    end
  end
end
