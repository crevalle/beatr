class AddPrivateToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :public, :boolean, default: true
  end
end
