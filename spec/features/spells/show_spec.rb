require 'rails_helper'

RSpec.describe 'spell show', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
     
      @spell_1 = @wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)
    end

    # User Story 4, Child Show 
    it 'shows a spell with its attributes' do
      # When I visit '/child_table_name/:id'
      visit "/spells/#{@spell_1.id}"
      # Then I see the child with that id including the child's attributes
      # (data from each column that is on the child table)
      expect(page).to have_content(@spell_1.name)
      expect(page).to have_content(@spell_1.learned)
      expect(page).to have_content(@spell_1.spell_level)
    end

    # User Story 14, Child Update 
    it "can update spells" do 
      # When I visit a Child Show page
      visit "/spells/#{@spell_1.id}"
      # Then I see a link to update that Child "Update Child"
      expect(page).to have_link("Update Spell")
      # When I click the link
      click_link("Update Spell")
      # I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
      expect(current_path).to eq("/spells/#{@spell_1.id}/edit")

      fill_in 'name', with: 'fire wall'
      fill_in 'learned', with: 'true'
      fill_in 'spell_level', with: '5'

      # When I click the button to submit the form "Update Child"
      click_button("Update Spell")
      # Then a `PATCH` request is sent to '/child_table_name/:id',
      expect(current_path).to eq("/spells/#{@spell_1.id}")
      # the child's data is updated,
      # and I am redirected to the Child Show page where I see the Child's updated information
      expect(page).to have_content("fire wall")
      expect(page).to have_content("true")
      expect(page).to have_content("5")
    end

    # User Story 20, Child Delete 
    it "can delete spells" do 
      # When I visit a child show page
      visit "/spells/#{@spell_1.id}"
      # Then I see a link to delete the child "Delete Child"
      expect(page).to have_link("Delete Spell")
      # When I click the link
      click_link("Delete Spell")
      # Then a 'DELETE' request is sent to '/child_table_name/:id',
      # the child is deleted,
      # and I am redirected to the child index page where I no longer see this child
      expect(current_path).to eq("/spells")

      expect(page).to_not have_content("#{@spell_1.name}")
    end
  end
end