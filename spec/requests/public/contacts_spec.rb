require 'rails_helper'

RSpec.describe 'Public::Contacts', type: :request do
  describe 'GET /contact' do
    it 'returns a successful response' do
      get contact_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the contact form' do
      get contact_path
      expect(response.body).to include('form')
    end
  end

  describe 'POST /contact' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          name: 'John Doe',
          email: 'john@example.com',
          phone: '1234567890',
          subject: 'Inquiry',
          message: 'I would like to know more about your products'
        }
      end

      it 'creates a new contact' do
        expect {
          post contact_path, params: { contact: valid_attributes }
        }.to change(Contact, :count).by(1)
      end

      it 'stores contact information correctly' do
        post contact_path, params: { contact: valid_attributes }
        contact = Contact.last
        expect(contact.name).to eq('John Doe')
        expect(contact.email).to eq('john@example.com')
        expect(contact.message).to include('products')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          name: '',
          email: '',
          message: ''
        }
      end

      it 'does not create a new contact' do
        expect {
          post contact_path, params: { contact: invalid_attributes }
        }.not_to change(Contact, :count)
      end

      # not_acceptable status only accept js
      it 'returns unprocessable entity status' do
        post contact_path, params: { contact: invalid_attributes }
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    context 'with invalid email format' do
      let(:invalid_email_attributes) do
        {
          name: 'John Doe',
          email: 'invalid-email',
          phone: '1234567890',
          subject: 'Test',
          message: 'Test message'
        }
      end

      it 'does not create a contact' do
        expect {
          post contact_path, params: { contact: invalid_email_attributes }
        }.not_to change(Contact, :count)
      end
    end
  end
end
