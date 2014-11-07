require 'rails_helper'

describe 'restaurants' do

  context 'no restaurants have been added' do

    it 'should display a prompt to add a restaurant when signed in' do
      _sign_in
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add a restaurant'
    end

    it 'should not display a prompt to add a restaurant unless signed in' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).not_to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do

	  it 'should display restaurants' do
      Restaurant.create(name:'KFC')
      visit '/restaurants'
	    expect(page).to have_content('KFC')
	    expect(page).not_to have_content('No restaurants yet')
	  end
	end

	context 'creating restaurants' do

	 	it 'prompts user to fill out a form, then displays the new restaurant' do
      _sign_in
		  visit '/restaurants'
		  click_link 'Add a restaurant'
		  fill_in 'Name', with: 'KFC'
		  click_button 'Create Restaurant'
		  expect(page).to have_content 'KFC'
		  expect(current_path).to eq '/restaurants'
 		end

 	context 'an invalid restaurant' do

	    it 'does not let you submit a name that is too short' do
        _sign_in
	      visit '/restaurants'
	      click_link 'Add a restaurant'
	      fill_in 'Name', with: 'kf'
	      click_button 'Create Restaurant'
	      expect(page).not_to have_css 'h2', text: 'kf'
	      expect(page).to have_content 'error'
	    end
  	end

	end

	context 'viewing restaurants' do

	  before do
	    @kfc = Restaurant.create(name:'KFC')
	  end

	  it 'lets a user view a restaurant' do
	   visit '/restaurants'
	   click_link 'KFC'
	   expect(page).to have_content 'KFC'
	   expect(current_path).to eq "/restaurants/#{@kfc.id}"
	  end
	end

	context 'editing restaurants' do

	  it 'lets a user edit a restaurant they created' do
      _sign_in
      _create_kfc
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
	    expect(page).to have_content 'Kentucky Fried Chicken'
	    expect(current_path).to eq '/restaurants'
	  end

    it 'does not let a user edit a restaurant that they did not create' do
      _sign_in
      visit '/restaurants'
      expect(page).not_to have_content 'Edit KFC'
    end
	end

	context 'deleting restaurants' do

	  it "removes a restaurant when a user created it and clicks a delete link" do
      _sign_in
      _create_kfc
	    visit '/restaurants'
	    click_link 'Delete KFC'
	    expect(page).not_to have_content 'KFC'
	    expect(page).to have_content 'Restaurant deleted successfully'
	  end

    it 'does not let a user delete a restaurant that they did not create' do
      _sign_in
      visit '/restaurants'
      expect(page).not_to have_content 'Delete KFC'
    end
	end

end