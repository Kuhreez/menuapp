class CustomerPredictor
  attr_reader :customer

  def initialize(customer)
    @customer = customer
  end

  def likely_day_to_dine
    return nil if customer.orders.blank?

    # initialize a hash with all day names as keys, with initial values of 0s
    days_hash = {}
    Date::DAYNAMES.each do |day_name|
      days_hash[day_name] = 0
    end

    customer.orders.each do |order|
      day_of_week_ordered = order.created_at.strftime('%A')
      days_hash[day_of_week_ordered] += 1
    end

    days_hash.max_by { |_k, v| v }.first
  end

  def likely_dish_to_order
    return nil if customer.orders.blank?

    dish_hash = {}
    customer.orders.each do |order|
      items = JSON.parse(order.order_items)
      next if items.blank?

      items.each do |item|
        item_record = MenuItem.find item['menu_item_id']
        item_name = item_record.name
        if dish_hash[item_name].present?
          dish_hash[item_name] += item['qty']
        else
          dish_hash[item_name] = item['qty']
        end
      end
    end

    dish_hash.max_by { |_k, v| v }.first
  end
end
