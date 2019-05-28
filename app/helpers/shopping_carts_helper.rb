module ShoppingCartsHelper

  def shopping_cart_how_many_tickets
    console
    return session[:shopping_cart].length if !session[:shopping_cart].nil?
    return 0
  end

  def shopping_cart_get_tickets
    if session[:shopping_cart].nil?
      return {}
    end
    Hash[*session[:shopping_cart].group_by{ |v| v.to_i }.flat_map{ |k, v| [k, v.size] }]
  end

end
