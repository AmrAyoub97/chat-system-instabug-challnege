# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.__elasticsearch__.create_index!
Message.import
app_1 = Application.create(name: "app_1")
app_2 = Application.create(name: "app_2")
app_3 = Application.create(name: "app_3")
app_4 = Application.create(name: "app_4")

chat_1_app_1 = Chat.create(chat_number: 1, application_id: 1)
chat_2_app_1 = Chat.create(chat_number: 2, application_id: 1)
chat_3_app_1 = Chat.create(chat_number: 3, application_id: 1)
chat_1_app_2 = Chat.create(chat_number: 1, application_id: 2)
chat_2_app_2 = Chat.create(chat_number: 2, application_id: 2)
chat_1_app_3 = Chat.create(chat_number: 1, application_id: 3)
chat_1_app_4 = Chat.create(chat_number: 1, application_id: 4)

msg_chat_1_app_1 = Message.create(body: 'test msg 1', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test msg 2', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test tex1', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test teee', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test text423', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test text1234', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test text33', message_number: 1, chat_id: 1, application_id: 1)
msg_chat_1_app_1 = Message.create(body: 'test text 22', message_number: 1, chat_id: 1, application_id: 1)