require 'rails_helper'

RSpec.describe 'show wizards', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
      @wizard_2 = Wizard.create!(name: "Logan", level: 7, graduated: true, age: 211)

      @spell_1 = @wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)
      @spell_2 = @wizard_1.spells.create!(name: "haste", learned: true, spell_level: 3)
    end

    # User Story 2, Parent Show 
    it 'shows a wizard and their attributes' do
      # When I visit '/parents/:id'
      visit "/wizards/#{@wizard_1.id}"
      # Then I see the parent with that id including the parent's attributes
      # (data from each column that is on the parent table)
      expect(page).to have_content(@wizard_1.name)
      expect(page).to have_content(@wizard_1.level)
      expect(page).to have_content(@wizard_1.graduated)
      expect(page).to have_content(@wizard_1.age)
    end

    # User Story 7, Parent Child Count
    it "displays a count of spells known by the wizard" do
      # When I visit a parent's show page
      visit "/wizards/#{@wizard_1.id}"
      # I see a count of the number of children associated with this parent
      expect(page).to have_content("Spell Count: 2")
    end

    # User Story 10, Parent Child Index Link
    it "has a link that goes to the wizards spell list" do 
      # When I visit a parent show page ('/parents/:id')
      visit "/wizards/#{@wizard_1.id}"
      # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
      expect(page).to have_link("Spell List")

      click_link("Spell List")

      expect(current_path).to eq("/wizards/#{@wizard_1.id}/wizard_spells")
    end

    # User Story 12, Parent Update 
    it "can update the wizard info" do 
      # When I visit a parent show page
      visit "/wizards/#{@wizard_1.id}"
      # Then I see a link to update the parent "Update Parent"
      expect(page).to have_link("Update Wizard")
      # When I click the link "Update Parent"
      click_link("Update Wizard")
      # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
      expect(current_path).to eq("/wizards/#{@wizard_1.id}/edit")
      # When I fill out the form with updated information
      fill_in 'name', with: 'Cole'
      fill_in 'level', with: '1'
      fill_in 'graduated', with: 'true'
      fill_in 'age', with: '4'
      # And I click the button to submit the form
      click_button("submit")
      # Then a `PATCH` request is sent to '/parents/:id',
      # the parent's info is updated,
      # and I am redirected to the Parent's Show page where I see the parent's updated info
      expect(current_path).to eq("/wizards/#{@wizard_1.id}")
      expect(page).to have_content("Cole")
      expect(page).to have_content("1")
      expect(page).to have_content("true")
      expect(page).to have_content("4")
    end

    # User Story 19, Parent Delete 
    it "can delete a Wizard" do 
      # When I visit a parent show page
      visit "/wizards/#{@wizard_1.id}"
      # Then I see a link to delete the parent
      expect(page).to have_link("Delete Wizard")
      # When I click the link "Delete Parent"
      click_link("Delete Wizard")
      # Then a 'DELETE' request is sent to '/parents/:id',
      # the parent is deleted, and all child records are deleted
      # and I am redirected to the parent index page where I no longer see this parent
      expect(current_path).to eq("/wizards")

      expect(page).to_not have_content(@wizard_1.name)
    end
  end
end