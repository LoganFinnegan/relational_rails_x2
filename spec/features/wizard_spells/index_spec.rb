require 'rails_helper'

RSpec.describe 'wizard_spell index', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
     
      @spell_2 = @wizard_1.spells.create!(name: "haste", learned: true, spell_level: 5)
      @spell_1 = @wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)
    end

    # User Story 5, Parent Children Index 
    it 'shows the spells assocaited with a wizard' do
      # When I visit '/parents/:parent_id/child_table_name'
      visit "/wizards/#{@wizard_1.id}/wizard_spells"
      # Then I see each Child that is associated with that Parent with each Child's attributes
      # (data from each column that is on the child table)
      within "#wizard_spell-#{@spell_1.id}" do 
        expect(page).to have_content(@spell_1.name)
        expect(page).to have_content(@spell_1.learned)
        expect(page).to have_content(@spell_1.spell_level)
      end
       
      within "#wizard_spell-#{@spell_2.id}" do 
        expect(page).to have_content(@spell_2.name)
        expect(page).to have_content(@spell_2.learned)
        expect(page).to have_content(@spell_2.spell_level)
      end
    end

    # User Story 13, Parent Child Creation 
    it "can create new spells" do 
      # When I visit a Parent Children Index page
      visit "/wizards/#{@wizard_1.id}/wizard_spells"
      # Then I see a link to add a new adoptable child for that parent "Create Child"
      expect(page).to have_link("Create Spell")
      # When I click the link
      click_link("Create Spell")
      # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
      expect(current_path).to eq("/wizards/#{@wizard_1.id}/wizard_spells/new")
      # When I fill in the form with the child's attributes:
      fill_in 'name', with: 'cone of cold'
      fill_in 'learned', with: 'true'
      fill_in 'spell_level', with: '5'
      # And I click the button "Create Child"
      click_button("Create Spell")
      # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
      expect(current_path).to eq("/wizards/#{@wizard_1.id}/wizard_spells")
      # a new child object/row is created for that parent,
      # and I am redirected to the Parent Childs Index page where I can see the new child listed
      expect(page).to have_content("cone of cold")
      expect(page).to have_content("true")
      expect(page).to have_content("5")
      # could make an argument for a wic here
    end

    # User Story 16, Sort Parent's Children in Alphabetical Order by name 
    it "lists spells in alphabetical order" do 
      # When I visit the Parent's children Index Page
      visit "/wizards/#{@wizard_1.id}/wizard_spells"
      # Then I see a link to sort children in alphabetical order
      expect(page).to have_link("Sort Alphabetically")
      # When I click on the link
      click_link("Sort Alphabetically")
      # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
      expect(@spell_1.name).to appear_before(@spell_2.name)
      expect(@spell_2.name).to_not appear_before(@spell_1.name)
    end

    # User Story 21, Display Records Over a Given Threshold 
    it "displays spells over x level" do 
      # When I visit the Parent's children Index Page
      visit "/wizards/#{@wizard_1.id}/wizard_spells"
      # I see a form that allows me to input a number value
      within '.spell_threshold' do
        # When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
        fill_in 'Spells above level', with: '4'

        click_button("submit")
      end
      # Then I am brought back to the current index page with only the records that meet that threshold shown.
      expect(current_path).to eq("/wizards/#{@wizard_1.id}/wizard_spells")

      expect(page).to have_content(@spell_2.name)
      expect(page).to_not have_content(@spell_1.name)
    end
  end
end