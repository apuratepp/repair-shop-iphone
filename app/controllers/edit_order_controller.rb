class EditOrderController < UIViewController
  attr_accessor :id

  def viewDidLoad
    super

    @orders_controller = OrdersController.alloc.initWithNibName(nil, bundle:nil)
    doneButton = UIBarButtonItem.alloc.initWithTitle("Save", style: UIBarButtonItemStyleDone, target:@orders_controller, action:'added')
    self.navigationItem.rightBarButtonItem = doneButton

    self.title ||= "Loading Order..."

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    # @table.setEditing(true, animated:true)

    @table.dataSource = self
    @table.delegate = self

    # p "EditOrderController #{@id} :D"
    @data ||= []
    Order.create do |order|
      @data = [order.id, order.email, order.created_at]
      self.title = "Order"
      @table.reloadData
    end
  end
  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @dataLabels = ['ID', 'Email', 'Created at']
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
                UITableViewCellStyleDefault, 
                reuseIdentifier: @reuseIdentifier)

    cell.accessoryType = UITableViewCellAccessoryNone;
    textField      = UITextField.alloc.initWithFrame(CGRectMake(110, 10, 185, 30))
    textField.textColor = UIColor.blackColor
    textField.adjustsFontSizeToFitWidth = true
    textField.text = @data[indexPath.row].to_s
    textField.setEnabled(true);
    # textField.keyboardType = UIKeyboardTypeEmailAddress;
    cell.contentView.addSubview(textField)

    cell.textLabel.text   = @dataLabels[indexPath.row]    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell
  end

end