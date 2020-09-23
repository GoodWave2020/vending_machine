require File.expand_path(File.dirname(__FILE__) + '/drink')
require File.expand_path(File.dirname(__FILE__) + '/inventory_controller')
class VendingMachine
  attr_reader :slot_money, :sale_money, :products

  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @ic = InventoryController.new
    @products = @ic.products
    @slot_money = 0
    @sale_money = 0
  end

  def insert_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  def purchasable_list
    drink_list = {}
    @products.each do |name, price|
      if check_stock_and_money(name)
         drink_list[name] = price
      end
    end
    drink_list
  end

  def return_money
    @slot_money.tap {@slot_money = 0}
  end

  def check_stock_and_money(drinks)
    if @slot_money >= @products[drinks] && @ic.inventory(drinks) > 0
      true
    else @slot_money > @products[drinks] && @ic.inventory(drinks) == 0
      false
    end
  end

  def purchase(drinks)
    if check_stock_and_money(drinks)
      @ic.dispense(drinks)
      @sale_money += @products[drinks]
      @slot_money -= @products[drinks]
    else
      false
    end
  end

  def current_inventory(drinks)
    @ic.inventory(drinks)
  end
end
