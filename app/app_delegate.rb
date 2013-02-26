class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    p "ieee"

    BubbleWrap::HTTP.get("http://repair-shop.dev/orders.json?auth_token=yLVRSLTjXHssxRq5vJuW") do |response|
      @data = BW::JSON.parse(response.body.to_str)
      p @data
    end

    true
  end
end
