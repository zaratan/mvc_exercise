# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model creation' do
    subject do
      create(:user)
    end

    it 'is creatable' do
      user = subject.reload
      expect(user.email).not_to be_nil
      expect(user.password).not_to be_nil
    end
  end
end
