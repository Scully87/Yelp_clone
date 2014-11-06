require 'rails_helper'

describe 'reviewing' do

  before do
    Restaurant.create(name: 'KFC')
  end

  it 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'
     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  it 'displays an average rating for all reviews' do
    _leave_review('So so', "1")
    _leave_review('Great', "5")
    expect(page).to have_content("Average rating:★★★☆☆")
  end

end

describe '#average_rating' do

  restaurant = Restaurant.create(name: "The Ivy")

  context 'no reviews' do

    it 'returns "N/A" when there are no reviews' do
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end

  context '1 review' do

    it 'returns that rating' do
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


