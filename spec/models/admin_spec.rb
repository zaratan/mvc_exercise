# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'Model creation' do
    subject do
      create(:admin)
    end

    it 'is creatable' do
      admin = subject.reload
      expect(admin.email).not_to be_nil
    end
  end
end
