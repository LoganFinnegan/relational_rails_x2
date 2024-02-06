require 'rails_helper'

RSpec.describe 'spell index', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
     
      @spell_1 = @wizard_1.spells.create!(name: "fireball", learned: true, spell_level: 3)
      @spell_2 = @wizard_1.spells.create!(name: "fear", learned: false, spell_level: 5)
      @spell_3 = @wizard_1.spells.create!(name: "haste", learned: true, spell_level: 3)
    end

    # User Story 3, Child Index 
    it 'shows the spells and their attributes' do
      # When I visit '/child_table_name'
      visit "/spells"
      # Then I see each Child in the system including the Child's attributes
      # (data from each column that is on the child table)
      expect(page).to have_content(@spell_1.name)
      expect(page).to have_content(@spell_1.learned)
      expect(page).to have_content(@spell_1.spell_level)
    end

    # User Story 8, Child Index Link
    it "has a link to spells on all pages" do
      # When I visit any page on the site
      visit '/spells'
      # Then I see a link at the top of the page that takes me to the Child Index
      expect(page).to have_link("Spells")

      click_on("Spells")

      expect(current_path).to eq('/spells')

      visit '/wizards'
      
      expect(page).to have_link("Spells")

      click_on("Spells")

      expect(current_path).to eq('/spells')
    end

    # User Story 15, Child Index only shows `true` Records 
    it "only show learned spells" do 
      # When I visit the child index
      visit "/spells"
      # Then I only see records where the boolean column is `true`
      expect(page).to have_content("#{@spell_1.name}")
      expect(page).to_not have_content("#{@spell_2.name}")
    end

    # User Story 18, Child Update From Childs Index Page 
    it "has a edit page for each spell" do 
      # When I visit the `child_table_name` index page or a parent `child_table_name` index page
      visit "/spells"
      # Next to every child, I see a link to edit that child's info
      within "#spell-#{@spell_1.id}" do
        expect(page).to have_link("Edit Spell: #{@spell_1.name}")
      end

      within "#spell-#{@spell_3.id}" do
        expect(page).to have_link("Edit Spell: #{@spell_3.name}")
      end

      expect(page).to_not have_content("#{@spell_2.name}")
      
      # When I click the link
      click_link("Edit Spell: #{@spell_1.name}")
      # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14
      expect(current_path).to eq("/spells/#{@spell_1.id}/edit")
    end

    # User Story 23, Child Delete From Childs Index Page 
    it "can remove spells" do 
      # When I visit the `child_table_name` index page or a parent `child_table_name` index page
      visit "/spells"
      # Next to every child, I see a link to delete that child
      within "#spell-#{@spell_1.id}" do
        expect(page).to have_link("Delete Spell")
        # When I click the link
        click_link("Delete Spell")
      end
      # I should be taken to the `child_table_name` index page where I no longer see that child
      expect(current_path).to eq("/spells")
      
      expect(page).to_not have_content(@spell_1.name)
    end
  end
end