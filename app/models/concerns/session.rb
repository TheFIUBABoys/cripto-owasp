class Session < ActiveRecord::Base
  belongs_to :user

  def expired?
    created_at < 30.seconds.ago
  end
end
