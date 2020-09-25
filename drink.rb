class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.cola
    cola = self.new :cola, 120
  end

  def self.redbull
    self.new :redbull, 200
  end

  def self.water
    self.new :water, 100
  end
end
