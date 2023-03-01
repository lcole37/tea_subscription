require 'rails_helper'

RSpec.describe 'Tea Subscription Request' do
  let!(:customers) { create_list(:customer, 3) }
  let!(:customer_1) { customers.first }
  let!(:customer_2) { customers.second }
  let!(:customer_3) { customers.third }

  let!(:c1_subs) { create_list(:subscription, 3, customer: customer_1) }
  let!(:c1_s1) { c1_subs.first }
  let!(:c1_s2) { c1_subs.second }
  let!(:c1_s3) { c1_subs.third }

  let!(:c2_subs) { create_list(:subscription, 3, customer: customer_1) }
  let!(:c2_s1) { c2_subs.first }
  let!(:c2_s2) { c2_subs.second }
  let!(:c2_s3) { c2_subs.third }

  let!(:c3_subs) { create_list(:subscription, 3, customer: customer_1) }
  let!(:c3_s1) { c3_subs.first }
  let!(:c3_s2) { c3_subs.second }
  let!(:c3_s3) { c3_subs.third }

  describe '.create' do
    context 'subscription creation' do
      let!(:tea) { create(:tea) }
      let!(:customer) { create(:customer) }

      it "creates a new subscription" do
        subscription_params = {
          title: "#{customer.first_name} #{customer.last_name}'s #{tea.title}",
          price: 7,
          frequency: 3,
          tea_id: tea.id,
          customer_id: customer.id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: subscription_params)

        new_sub = Subscription.last

        expect(response).to be_successful
        expect(response).to have_http_status(201)
        expect(Subscription.count).to eq(10)
        expect(new_sub.title).to eq(subscription_params[:title])
        expect(new_sub.price).to eq(subscription_params[:price])
        expect(new_sub.frequency).to eq('quarterly')
        expect(new_sub.tea_id).to eq(subscription_params[:tea_id])
        expect(new_sub.customer_id).to eq(subscription_params[:customer_id])
        expect(new_sub.status).to eq('active')
      end

      it "returns 422 if cannot be created" do
        subscription_params = {
          title: "",
          price: 7,
          frequency: 3,
          tea_id: tea.id,
          customer_id: customer.id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: subscription_params)

        expect(response).to_not be_successful
        expect(response).to have_http_status(422)
        expect(Subscription.count).to eq(9)
      end
    end

    describe ".update" do
      context 'subscription cancellation' do
        it "can cancel a customer subscription" do
          id = create(:subscription, status: 0).id
          previous_status = Subscription.last.status
          subscription_params = { status: 1 }

          headers = { 'CONTENT_TYPE' => 'application/json' }

          patch "/api/v1/subscriptions/#{id}", headers: headers, params: JSON.generate(subscription: subscription_params)
          subscription = Subscription.find_by(id: id)

          new_sub = Subscription.last

          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(subscription.status).to_not eq(previous_status)
          expect(subscription.status).to eq('canceled')
        end
      end

    end


  end
end
