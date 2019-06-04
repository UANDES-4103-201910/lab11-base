module ShoppingCartsHelper

  def shopping_cart_empty?
    return session[:shopping_cart].nil? || session[:shopping_cart].length == 0
  end

  def shopping_cart_how_many_tickets
    return session[:shopping_cart].length if !session[:shopping_cart].nil?
    return 0
  end

  def shopping_cart_total
    if !session[:shopping_cart] || !session[:shopping_cart].length
      return 0
    end

    sum = 0

    session[:shopping_cart].each { |t|
        tt = TicketType.find(t)
        sum += tt.price
    }

    return sum
  end

  def shopping_cart_get_tickets
    if session[:shopping_cart].nil?
      return {}
    end
    Hash[*session[:shopping_cart].group_by{ |v| v.to_i }.flat_map{ |k, v| [k, v.size] }]
  end

end
