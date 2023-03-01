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
    if @sub.update(subscription_params)
      render json: SubscriptionSerializer.new(@sub), status: 200
    else
      render json: @sub.errors.full_messages, status: 422
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id, :customer_id, :status)
  end
end
