class EditOrderController < UIViewController
  attr_accessor :order_id

  def viewDidLoad
    super

    #@orders_controller = OrdersController.alloc.initWithNibName(nil, bundle:nil)

    self.title ||= "Loading Order..."

    doneButton = UIBarButtonItem.alloc.initWithTitle("Save", 
                      style: UIBarButtonItemStyleDone, 
                      target:self, 
                      action:'save')
    
    self.navigationItem.rightBarButtonItem = doneButton

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    # @table.setEditing(true, animated:true)

    @table.dataSource = self
    @table.delegate = self

    @dataLabels = ['ID', 'Email', 'Created at']
    @data ||= []

    if @order_id.nil?
      Order.create do |order|
        @data = [order.id, order.email, order.created_at]
        self.title = "Order ##{order.id}"
        @table.reloadData
      end
    else
      Order.find(@order_id) do |order|
        @order = order
        @data = [order.id, order.email, order.created_at]        
        self.title = "Order ##{order.id}"
        @table.reloadData
      end
    end
  end
  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    # http://stackoverflow.com/questions/409259/having-a-uitextfield-in-a-uitableviewcell
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
                UITableViewCellStyleDefault, 
                reuseIdentifier: @reuseIdentifier)

    cell.accessoryType = UITableViewCellAccessoryNone;
    textField      = UITextField.alloc.initWithFrame(CGRectMake(110, 10, 185, 30))
    textField.textColor = UIColor.blackColor
    # textField.backgroundColor = UIColor.whiteColor
    textField.adjustsFontSizeToFitWidth = true
    textField.text = @data[indexPath.row].to_s
    textField.setEnabled(true);
    # textField.keyboardType = UIKeyboardTypeEmailAddress;

    cell.textLabel.text   = @dataLabels[indexPath.row]    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.contentView.addSubview(textField)

    cell
  end
  def save
    @order.save do |order|
      #@data = [order.id, order.email, order.created_at]
      @table.reloadData
    end
  end
end