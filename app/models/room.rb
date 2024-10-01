class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> {where(is_private: false)}
  after_create_commit {broadcast_append_to "rooms" }
  has_many :messages
  has_many :users, through: :messages

  def unique_users_count
    users.distinct.count
  end
end
