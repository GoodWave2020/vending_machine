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

class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @drink_table = {}
    5.times { store Drink.cola }
    @slot_money = 0
    @sale_money = 0
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    puts "slot_money(money)を使っています"
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    puts "投入金額:#{@slot_money}"
    puts "---------"
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "釣銭:#{@slot_money}"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  def store(drink)
    nil.tap do
      @drink_table[drink.name] = { price: drink.price, drinks: [] } unless @drink_table.has_key? drink.name
      @drink_table[drink.name][:drinks] << drink
    end
  end

  def stock_info
    puts "stock_infoを使っています"
    if @drink_table_arranged == nil
      @drink_table_arranged = Hash[@drink_table.map {|name, info| [name, { price: info[:price], stock: info[:drinks].size }] }]
    end
    puts "コーラの値段:#{@drink_table_arranged[:cola][:price]}"
    puts "ストック:#{@drink_table_arranged[:cola][:stock]}"
    puts "---------"
  end

  def check_stock_and_money
    puts "check_stock_and_moneyを使っています"
    if @slot_money >= 100 && @drink_table_arranged[:cola][:stock] > 0
       @drink_table_arranged[:cola][:stock] -= 1
       puts "現在ストック:#{@drink_table_arranged[:cola][:stock]}"
       @sale_money += @drink_table_arranged[:cola][:price]
       puts "売上:#{@sale_money}"
       @slot_money -= @drink_table_arranged[:cola][:price]
       return_money
    else
       return_money
    end
    puts "---------"
  end

end

class Drink
  attr_accessor :name, :price

  def self.cola
    self.new :cola, 120
  end

  def self.redbull
    self.new :redbull, 200
  end

  def self.water
    self.new :water, 100
  end

  def initialize(name, price)
    @name = name
    @price = price
  end
end

vm = VendingMachine.new
vm.slot_money(500)
vm.stock_info
vm.check_stock_and_money
vm.stock_info
