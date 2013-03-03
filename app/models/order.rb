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
      # p response.ok?
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
  
  def self.find(id, &block)
    BW::HTTP.get("http://repair-shop.dev/orders/#{id}.json", {}) do |response|
      json = BW::JSON.parse(response.body.to_str)
      order = Order.new(json)
      # p order
      block.call(order)
    end
  end

  def save(&block)
    json = BW::JSON.generate({
      'id' => self.id,
      'email' => self.email + "!",
      'created_at' => self.created_at,
    })

    BW::HTTP.put("http://repair-shop.dev/orders/#{self.id}.json", {:order => json}) do |response|
      p response
      #json = BW::JSON.parse(response.body.to_str)
      #order = Order.new(json)
      order = self
      block.call(order)
    end
  end

end