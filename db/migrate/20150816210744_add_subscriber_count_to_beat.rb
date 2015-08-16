class AddSubscriberCountToBeat < ActiveRecord::Migration
  def change
    add_column :beats, :subscriber_count, :integer, default: 0
  end
end
