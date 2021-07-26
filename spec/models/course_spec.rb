require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it {should have_many(:tutors)}
    it {should accept_nested_attributes_for(:tutors)}
  end

  describe "response data" do
    let (:course) {create(:course)}
  end
end
