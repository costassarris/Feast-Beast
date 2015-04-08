require 'rails_helper'
require_relative 'helpers.rb'

feature 'reviewing' do
  let!(:kebab){Feast.create(name: 'Kebabs', description: 'OK', address: 'London')}

  scenario 'allows users to write a review' do
    sign_up
    click_link "Review #{kebab.name}"
    fill_in 'Thoughts', with: 'solid'
    select '5', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/feasts'
    expect(page).to have_content 'solid'
  end

  scenario 'deletes reviews of a deleted feast' do
    sign_up
    click_link 'Review Kebabs'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete Kebabs'
    expect(Review.all.any?).to eq false
  end
end