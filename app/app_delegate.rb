class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # Order.all do |orders|
    #   p orders
    # end
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @orders_controller = OrdersController.alloc.initWithNibName(nil, bundle:nil)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(@orders_controller)
    @window.makeKeyAndVisible

    true
  end
end
