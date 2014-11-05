require 'rails_helper'

describe 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: "It was an abomination")
  end

  xit 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse KFC'
    save_and_open_page
    expect(page).to have_content('1 endorsement')
  end

end