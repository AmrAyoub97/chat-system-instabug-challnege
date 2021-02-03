class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :token
      t.string :name
      t.integer :chat_count

      t.timestamps
    end
  end
end
