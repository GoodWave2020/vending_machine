require File.expand_path(File.dirname(__FILE__) + '/drink')
class InventoryController
  attr_reader :products
  def initialize
    @drink_table = {}
      5.times { store Drink.cola }
      5.times { store Drink.redbull }
      5.times { store Drink.water }
    @products = { cola: Drink.cola.price, redbull: Drink.redbull.price, water: Drink.water.price }
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
