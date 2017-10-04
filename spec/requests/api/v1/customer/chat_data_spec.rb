describe 'ChatDatum' do
  let!(:customer){ create(:customer) }
  let!(:chat_room){ create(:chat_room) }
  let!(:chat_member){ create(:chat_member, chat_room: chat_room, customer: customer) }
  let!(:chat_datum){ create(:chat_datum, chat_room: chat_room, customer: customer) }
  let!(:chat_data){ create_list(:chat_datum, 10, chat_room: chat_room, customer: customer) }

  describe 'GET api/v1/customer/chat_rooms/:chat_room_id/chat_data' do
    before do
      get api_v1_customer_chat_room_chat_data_path(chat_room), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return customer chat data' do
      json = JSON.parse(response.body)
      text = json.map{ |j| j['text'] }
      expect(text).to include chat_datum.text
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end

  end

end
