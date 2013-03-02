class EditOrderController < UIViewController
  attr_accessor :id

  def viewDidLoad
    super

    @orders_controller = OrdersController.alloc.initWithNibName(nil, bundle:nil)
    doneButton = UIBarButtonItem.alloc.initWithTitle("Done", style: UIBarButtonItemStyleDone, target:@orders_controller, action:'added')
    self.navigationItem.rightBarButtonItem = doneButton

    p "EditOrderController #{@id} :D"
    Order.create do |order|
      # p order
    end


  end
end