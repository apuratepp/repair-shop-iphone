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
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
                UITableViewCellStyleSubtitle, 
                reuseIdentifier: @reuseIdentifier)

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    # p @data
    # p indexPath.row
    # p @data[indexPath.row]

    cell.textLabel.text = "#{@data[indexPath.row]}"
    # cell.textLabel.text       = @data[indexPath.row]
    # cell.detailTextLabel.text = order.created_at
    
    cell
  end

end