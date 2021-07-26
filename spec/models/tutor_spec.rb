require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe 'associations' do
    it {should belong_to(:course)}
  end
end
