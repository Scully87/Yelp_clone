require 'rails_helper'

describe 'restaurants' do

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  context 'no restaurants have been added' do

      it 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do

	  before do
	    Restaurant.create(name: 'KFC')
	  end

	  it 'should display restaurants' do
	    visit '/restaurants'
	    expect(page).to have_content('KFC')
	    expect(page).not_to have_content('No restaurants yet')
	  end
	end

	context 'creating restaurants' do

	 	it 'prompts user to fill out a form, then displays the new restaurant' do
		  visit '/restaurants'
		  click_link 'Add a restaurant'
		  fill_in 'Name', with: 'KFC'
		  click_button 'Create Restaurant'
		  expect(page).to have_content 'KFC'
		  expect(current_path).to eq '/restaurants'
 		end

 	context 'an invalid restaurant' do

	    it 'does not let you submit a name that is too short' do
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

	  before do
	    Restaurant.create(name:'KFC')
    end

	  xit 'lets a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
	    fill_in 'Name', with: 'Kentucky Fried Chicken'
	    click_button 'Update Restaurant'
	    expect(page).to have_content 'Kentucky Fried Chicken'
	    expect(current_path).to eq '/restaurants'
	  end

    it 'does not let a user edit a restaurant that they did not create' do
      visit '/restaurants'
      expect(page).not_to have_content 'Edit KFC'
    end
	end

	context 'deleting restaurants' do

	  before do
	    Restaurant.create(:name => "KFC")
	  end

	  it "removes a restaurant when a user clicks a delete link" do
	    visit '/restaurants'
	    click_link 'Delete KFC'
	    expect(page).not_to have_content 'KFC'
	    expect(page).to have_content 'Restaurant deleted successfully'
	  end
	end

	describe '#average_rating' do

	  context 'no reviews' do

	    it 'returns "N/A" when there are no reviews' do
	      restaurant = Restaurant.create(name: "The Ivy")
	      expect(restaurant.average_rating).to eq 'N/A'
	        end
	    end
		end

	  context '1 review' do

      it 'returns that rating' do
        restaurant = Restaurant.create(name: "The Ivy")
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
	  end

	  context 'multiple reviews' do

      it 'returns the average' do
        restaurant = Restaurant.create(name: "The Ivy")
        restaurant.reviews.create(rating: 1)
        restaurant.reviews.create(rating: 5)
        expect(restaurant.average_rating).to eq 3
      end
	  end

end