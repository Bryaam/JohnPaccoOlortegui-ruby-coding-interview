class Tweet < ApplicationRecord
  belongs_to :user

  scope :from_user, -> (username) { joins(:user).where(users: { username: username })  if username.present?}
end
