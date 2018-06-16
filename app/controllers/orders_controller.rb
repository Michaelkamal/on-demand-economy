class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]
    before_action :authorize_request ,:is_verified
    include Callprovider
    def create
        order = Order.create!(order_params)
        order.created_by=current_user.id
        order.save
        time_in_minute =(order.time.to_i - order.created_at.to_i).to_i/60

        if (time_in_minute >= 60)
            OrderScheduleJob.set(wait: (time_in_minute-60).minute).perform_later(order)
            json_response({message: Message.success})
        else
            call_provider(order)
        end
    end

    def show
        pending_orders=Order.where(created_by: current_user.id,status: "pending").order(time: :desc)
        active_orders=Order.where(created_by: current_user.id,status: "active").order(time: :desc)
        upcomig_orders=Order.where(created_by: current_user.id,status: "upcoming").order(time: :desc).page(params[:page_number])
        history_orders=Order.where(created_by: current_user.id,status: "history").order(time: :desc).page(params[:page_number])
        history_pages=history_orders.total_pages
        response={message: Message.success ,history_pages: history_pages, history: history_orders,active: active_orders ,upcoming: upcomig_orders}
        
        json_response(response)

    end

    def set_order
        @order = Order.find(params[:id])
    end
    
    
    private
    # def self.call_provider(order)

    #     @provider=Provider.find(order.provider_id)
    #     provider_url=@provider.url
    #     response = Data_provider::Data.new(order,provider_url)
    #     data=response.get_response.body

    #     # json_response({ message: Message.success , data: JSON[data]}) 
    #     render json: data
    # end

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:provider_id,:payment_method,:time,:title,:images,:weight,:description)
    end
end
