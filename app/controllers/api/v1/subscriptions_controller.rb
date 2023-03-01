class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: {error: 'Error'}, status: 404
    end
  end

  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id, :customer_id, :status)
  end
end
