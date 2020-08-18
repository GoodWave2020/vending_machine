class VendingMachine
  attr_reader :slot_money

  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @ic = InventoryController.new
    @price = {cola: Drink.cola.price, water: Drink.water.price, redbull: Drink.redbull.price}
    @slot_money = 0
    @sale_money = 0
  end

  def current_slot_money
    @slot_money
  end

  def insert_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  def return_money
    @slot_money.tap {@slot_money = 0}
  end

  def sales
    @sale_money
  end

  def check_stock_and_money(drinks)
    if @slot_money >= @price[drinks] && @ic.inventory(drinks) > 0
      true
    else @slot_money > @price[drinks] && @ic.inventory(drinks) == 0
      false
    end
  end

  def purchase(drinks)
    if check_stock_and_money(drinks)
      @ic.dispense(drinks)
      @sale_money += @price[drinks]
      @slot_money -= @price[drinks]
    else
      false
    end
  end

  def current_inventory(drinks)
    @ic.inventory(drinks)
  end
end

class InventoryController
  def initialize
    @drink_table = {}
      5.times { store Drink.cola }
      5.times { store Drink.redbull }
      5.times { store Drink.water }
  end

  def store(drink)
    nil.tap do
      @drink_table[drink.name] = { price: drink.price, drinks: [] } unless @drink_table.has_key? drink.name
      @drink_table[drink.name][:drinks] << drink
    end
  end

  def inventory(drinks)
    @drink_table[drinks][:drinks].size
  end

  def dispense(drinks)
    @drink_table[drinks][:drinks].shift()
  end
end

class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.cola
    self.new :cola, 120
  end

  def self.redbull
    self.new :redbull, 200
  end

  def self.water
    self.new :water, 100
  end
end
