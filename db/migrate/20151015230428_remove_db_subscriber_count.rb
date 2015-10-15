class RemoveDbSubscriberCount < ActiveRecord::Migration
  def change
    remove_column :channels, :subscriber_count, :integer, default: 0
  end
end
