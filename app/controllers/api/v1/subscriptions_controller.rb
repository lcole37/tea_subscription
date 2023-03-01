class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: {error: 'Error'}, status: 422
    end
  end

  def update
    @sub = Subscription.find_by_id(params[:id])
    @sub.update(subscription_params)
    render json: SubscriptionSerializer.new(@sub), status: 200
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id, :customer_id, :status)
  end
end
