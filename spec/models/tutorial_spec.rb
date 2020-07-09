require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'instance methods' do
    describe 'toggle classroom' do
      it 'can toggle classroom status' do
        tutorial = create(:tutorial)
        expect(tutorial.classroom).to eq(false)
        tutorial.toggle_classroom
        expect(tutorial.classroom).to eq(true)
      end
    end
  end
end
