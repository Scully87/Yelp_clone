require 'rails_helper'

  def _sign_in
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def _sign_in_2
    visit '/users/sign_up'
    fill_in('Email', with: 'user@email.com')
    fill_in('Password', with: '1234abcd')
    fill_in('Password confirmation', with: '1234abcd')
    click_button('Sign up')
  end

  def _create_kfc
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end
