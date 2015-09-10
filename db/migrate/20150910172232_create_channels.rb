class CreateChannels < ActiveRecord::Migration
  def up
    create_table :channels do |t|
      t.string :name
      t.integer :subscriber_count, default: 0

      t.timestamps null: false
    end

    add_index :channels, :name, unique: true

    remove_column :beats, :name
    remove_column :beats, :subscriber_count

    add_column :beats, :channel_id, :integer
    add_index :beats, :channel_id
  end

  def down
    remove_column :beats, :channel_id

    add_column :beats, :subscriber_count, :integer
    add_column :beats, :name, :string

    drop_table :channels
  end
end
