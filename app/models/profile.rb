# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Profile < ApplicationRecord
  belongs_to :user

  def send_email
    ProfileMailer.notify_user(user).deliver_later
  end
end
