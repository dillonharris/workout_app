require 'rails_helper'

RSpec.feature 'Listing Exercises' do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: 'john@example.com', password: 'password')
    @sarah = User.create(first_name: "Sarah", last_name: "Doe", email: 'sarah@example.com', password: 'password')
    login_as(@john)

    @exercise1 = @john.exercises.create(duration_in_min: 20, workout: 'Body building routine', workout_date: Date.today)
    @exercise2 = @john.exercises.create(duration_in_min: 20, workout: 'Cardio', workout_date: Date.today)

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "shows users workout for last 7 days" do
    visit '/'

    click_link 'My Lounge'
    expect(page).to have_content(@exercise1.duration_in_min)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)
    expect(page).to have_content(@exercise2.duration_in_min)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)
  end

  scenario "shows a list of users friends" do
    visit '/'

    click_link 'My Lounge'
    expect(page).to have_content('My Friends')
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link("Unfollow")
  end
end
