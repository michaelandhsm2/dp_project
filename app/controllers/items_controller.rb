class ItemsController < ApplicationController

  def index
    @store = Store.find(params[:id])
    @items = @store.items.paginate(page: params[:page], :per_page => 5)

  end

  def show
    @item = Item.find(params[:id])
    @item.coupons.each do |e|
      if e.start_date < DateTime.current && e.end_date > DateTime.current
        flash_message_now :info, "#{e.event.name} - You will get $#{e.free_cash} free for every $#{e.minimum_spending} spent on items like this between #{e.start_date.strftime("%b %e, %C%y")} and #{e.end_date.strftime("%b %e, %C%y")}."
      end
    end
    @item.specials.each do |e|
      if e.start_date < DateTime.current && e.end_date > DateTime.current
        flash_message_now :info, "#{e.event.name} - '#{@item.name}' is currently #{e.discount}% off between #{e.start_date.strftime("%b %e, %C%y")} and #{e.end_date.strftime("%b %e, %C%y")}."
      end
    end
    @item.store.events.each do |e|
      if e.start_date < DateTime.current && e.end_date > DateTime.current
        flash_message_now :info, "#{e.event.name} - Everything in #{e.store.name} is #{e.discount}% off between #{e.start_date.strftime("%b %e, %C%y")} and #{e.end_date.strftime("%b %e, %C%y")}."
      end
    end
  end

  def catalog
    @items = Item.all.paginate(page: params[:page], :per_page => 8)
    @order_item = current_order.order_items.new
  end

end
