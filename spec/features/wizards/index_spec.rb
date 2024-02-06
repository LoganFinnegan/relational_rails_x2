require 'rails_helper'

RSpec.describe 'wizard index', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
      @wizard_2 = Wizard.create!(name: "Logan", level: 7, graduated: true, age: 211)
    end
    
    # User Story 1, Parent Index 
    it 'shows each wizard' do
      # When I visit '/parents'
      visit "/wizards"
      # Then I see the name of each parent record in the system
      expect(page).to have_content(@wizard_1.name)
      expect(page).to have_content(@wizard_2.name)
    end

    # User Story 6, Parent Index sorted by Most Recently Created 
    it "shows wizards ordered by creation date" do 
      # When I visit the parent index,
      visit "/wizards"
      # I see that records are ordered by most recently created first
      # And next to each of the records I see when it was created
      # require 'pry'; binding.pry
      expect(@wizard_2.name).to appear_before(@wizard_1.name)
      expect(@wizard_1.name).to_not appear_before(@wizard_2.name)

      within "#wizard-#{@wizard_1.id}" do
        expect(page).to have_content(@wizard_1.created_at)
      end

      within "#wizard-#{@wizard_2.id}" do
        expect(page).to have_content(@wizard_2.created_at)
      end
    end

    # User Story 9, Parent Index Link
    it "has a link to wizards on all pages" do
      # When I visit any page on the site
      visit '/wizards'
      # Then I see a link at the top of the page that takes me to the Parent Index
      expect(page).to have_link("Wizards")

      click_on("Wizards")

      expect(current_path).to eq('/wizards')

      visit '/spells'
      
      expect(page).to have_link("Wizards")

      click_on("Wizards")

      expect(current_path).to eq('/wizards')
    end

    # User Story 11, Parent Creation 
    it "can create a new wizard" do
      # When I visit the Parent Index page
      visit "/wizards"
      # Then I see a link to create a new Parent record, "New Parent"
      expect(page).to have_link("New Wizard")
      # When I click this link
      click_link("New Wizard")
      # Then I am taken to '/parents/new' where I  see a form for a new parent record
      expect(current_path).to eq("/wizards/new")
      # When I fill out the form with a new parent's attributes:
      fill_in "name", with: "Gale"
      fill_in "level", with: "1"
      fill_in "graduated", with: "true"
      fill_in "age", with: "31"
      # And I click the button "Create Parent" to submit the form
      click_button("Create Wizard")
      # Then a `POST` request is sent to the '/parents' route, 
      # a new parent record is created,
      # and I am redirected to the Parent Index page where I see the new Parent displayed.
      expect(current_path).to eq("/wizards")

      expect(page).to have_content("Name: Gale")
    end

     # User Story 17, Parent Update From Parent Index Page 
     it "has a edit link next to each wizard" do 
      # When I visit the parent index page
      visit "/wizards"
      # Next to every parent, I see a link to edit that parent's info
      within "#wizard-#{@wizard_1.id}" do
        expect(page).to have_link("Edit Wizard: #{@wizard_1.name}")
      end
      
      within "#wizard-#{@wizard_2.id}" do
        expect(page).to have_link("Edit Wizard: #{@wizard_2.name}")
      end
      # When I click the link
      click_link("Edit Wizard: #{@wizard_1.name}")
      # I should be taken to that parent's edit page where I can update its information just like in User Story 12
      expect(current_path).to eq("/wizards/#{@wizard_1.id}/edit")
    end

    # User Story 22, Parent Delete From Parent Index Page 
    it "can delete a wizard" do 
      # When I visit the parent index page
      visit "/wizards"
      # Next to every parent, I see a link to delete that parent
      within "#wizard-#{@wizard_1.id}" do
        expect(page).to have_link("Delete Wizard")
        # When I click the link
        click_link("Delete Wizard")
      end
      # I am returned to the Parent Index Page where I no longer see that parent
      expect(current_path).to eq("/wizards")

      expect(page).to_not have_content(@wizard_1.name)
    end
  end
end