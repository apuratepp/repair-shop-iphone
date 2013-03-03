class OrdersController < UIViewController
  def viewDidLoad
    super

    rightButton = UIBarButtonItem.alloc.initWithTitle("Add", style: UIBarButtonItemStyleBordered, target:self, action:'new')
    self.navigationItem.rightBarButtonItem = rightButton

    self.title ||= "Loading Orders..."

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    @table.dataSource = self
    @table.delegate = self


    @data ||= []
    Order.all do |orders|
      @data = orders
      self.title = "Orders"
      @table.reloadData
    end
  end
  def added
    p "added :D"
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

    order = @data[indexPath.row]

    cell.textLabel.text       = order.email
    cell.detailTextLabel.text = order.created_at
    
    cell
  end
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    # http://stackoverflow.com/questions/9697770/push-new-view-on-clicking-table-cell-hows-that-possible
    order = @data[indexPath.row]
    @edit_order_controller = EditOrderController.alloc.initWithNibName(nil, bundle:nil)
    @edit_order_controller.order_id = order.id
    self.navigationController.pushViewController(@edit_order_controller, animated: true)
  end
  def new
    @edit_order_controller = EditOrderController.alloc.initWithNibName(nil, bundle:nil)
    self.navigationController.pushViewController(@edit_order_controller, animated: true)
  end

end