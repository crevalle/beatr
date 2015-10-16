class Beat < ActiveRecord::Base

  belongs_to :channel

  scope :in_last, ->(time) { where 'created_at >= ?', time.ago }
  scope :rev_cron, -> { order created_at: :desc }

end

