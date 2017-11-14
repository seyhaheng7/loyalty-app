describe 'CustomerChatSupport' do
  let!(:customer){ create(:customer) }
  let!(:customer2){ create(:customer) }
  let!(:chat_room){ create(:chat_room) }
  let!(:chat_room2){ create(:chat_room) }
  let!(:chat_member){ create(:chat_member, customer: customer, chat_room: chat_room) }
  let!(:chat_member2){ create(:chat_member, customer: customer2, chat_room: chat_room2) }

  describe 'GET api/v1/customer/chat_rooms' do
    before do
      get api_v1_customer_chat_rooms_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return list of chat rooms' do
      json = JSON.parse(response.body)
      chat_room_id = json.map{ |j| j['id'] }
      expect(chat_room_id).to include chat_room.id
    end

    it 'not to return other chat room' do
      json = JSON.parse(response.body)
      chat_room_id = json.map{ |j| j['id'] }
      expect(chat_room_id).not_to include chat_room2.id
    end

  end

  describe 'POST api/v1/customer/chat_rooms' do

    let!(:customer3){ create(:customer) }

    before do
      post api_v1_customer_chat_rooms_path, headers: customer.create_new_auth_token, params: { customer_id: customer3.id }
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return chat of member' do
      json = JSON.parse(response.body)
      chat_room = ChatRoom.find json['id']
      expect(chat_room.customers).to include customer3
      expect(chat_room.customers).to include customer
    end

  end

end
