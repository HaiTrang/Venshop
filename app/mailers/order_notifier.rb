class OrderNotifier < ActionMailer::Base
  def received(order)    
    @order = order    
    mail to: @order[0]["Email"], subject: '(Venshop) Confirm order information'
    
  end
  def shipped(order)
    @order = order    
    mail to: @order[0]["Email"], subject: '(Venshop) Confirm information'
  end
end
