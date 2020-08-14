# このコードをコピペしてrubyファイルに貼り付け、そのファイルをirbでrequireして実行しましょう。
# 例
# irb
# require '/Users/shibatadaiki/work_shiba/full_stack/sample.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money

# 自動販売機の制御
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @drink_table = {}
      5.times { store Drink.cola }
      5.times { store Drink.redbull }
      5.times { store Drink.water }
    @slot_money = 0
    @sale_money = 0
  end

  def current_slot_money
    @slot_money
  end

  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  def return_money
    @slot_money = 0
  end

  def check_stock_and_money(drinks)
    if @slot_money >= @drink_table[drinks][:price] && @drink_table[drinks][:drinks].size > 0
       purchase(drinks)
       return return_money
    else @slot_money > @drink_table[drinks][:price] && @drink_table[drinks][:drinks].size == 0
       return false
    end
  end
end

# 売り上げ管理
class Sales_management

  def purchase(drinks)
    @drink_table[drinks][:drinks].shift()
    @sale_money += @drink_table[drinks][:price]
    @slot_money -= @drink_table[drinks][:price]
  end

  def sales
    @sale_money
  end

  def store(drink)
    nil.tap do
      @drink_table[drink.name] = { price: drink.price, drinks: [] } unless @drink_table.has_key? drink.name
      @drink_table[drink.name][:drinks] << drink
    end
  end


end

# 在庫管理
class Inventory_management
  def stock(drinks)
    @drink_table[drinks][:drinks].size
  end
end

# 飲み物作るところ
class Drink
  class << self
    attr_reader :name, :price
    def initialize(name, price)
      @name = name
      @price = price
    end

    def cola
      self.new :cola, 120
    end

    def redbull
      self.new :redbull, 200
    end

    def water
      self.new :water, 100
    end
  end
end


vm = VendingMachine.new
sm = Sales_management.new(:cola)
im = Inventory_management.new
vm.slot_money(500)
# vm.stock_and_price(:cola)
vm.check_stock_and_money(:cola)
# vm.sales
