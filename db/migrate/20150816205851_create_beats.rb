class CreateBeats < ActiveRecord::Migration
  def change
    create_table :beats do |t|
      t.string :name
      t.string :ip

      t.timestamps null: false
    end
  end
end
