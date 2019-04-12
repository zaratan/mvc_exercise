# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint(8)        not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#

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
