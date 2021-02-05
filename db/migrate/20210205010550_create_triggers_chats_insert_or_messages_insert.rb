# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersChatsInsertOrMessagesInsert < ActiveRecord::Migration[5.1]
  def up
    create_trigger("chats_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("chats").
        after(:insert) do
      "UPDATE applications SET chat_count = chat_count + 1 WHERE id = NEW.application_id;"
    end

    create_trigger("messages_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("messages").
        after(:insert) do
      "UPDATE chats SET messages_count = messages_count + 1 WHERE id = NEW.chat_id;"
    end
  end

  def down
    drop_trigger("chats_after_insert_row_tr", "chats", :generated => true)

    drop_trigger("messages_after_insert_row_tr", "messages", :generated => true)
  end
end
