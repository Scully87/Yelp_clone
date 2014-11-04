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

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  it 'displays an average rating for all reviews' do
<<<<<<< HEAD
    leave_review('So so', "3")
    leave_review('Great', "5")
    expect(page).to have_content("Average rating: 4")
=======
      leave_review('So so', "3")
      leave_review('Great', "5")
      expect(page).to have_content("Average: 4")
>>>>>>> f441f0c3a36be69c8548d5b0e9b10c549fbec88e
  end

end