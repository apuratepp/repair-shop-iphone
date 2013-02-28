class Order
  PROPERTIES = [:id, :email, :created_at]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def self.create(&block)
    BW::HTTP.post("http://repair-shop.dev/orders.json", {}) do |response|
      p response.ok?
      json = BW::JSON.parse(response.body.to_str)
      order = Order.new(json)
      block.call(order)
    end
  end
  def self.all(&block)
    BW::HTTP.get("http://repair-shop.dev/orders.json") do |response|
      orders ||= []
      BW::JSON.parse(response.body.to_str).each do |order|
        orders << Order.new(order)
      end
      block.call(orders)
    end
  end



end