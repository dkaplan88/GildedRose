require './item.rb'

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.map(&:update_quality)
  end

  class Item
    def initialize(name, quality, sell_in)
      @item = klass_for(name).new(quality, sell_in)
    end

    def klass_for(name)
      case name
      when '+5 Dexterity Vest', 'Elixir of the Mongoose', 'Conjured Mana Cake'
        Normal
      when 'Aged Brie'
        AgedBrie
      when 'Sulfuras, Hand of Ragnaros'
        Sulfuras
      when 'Backstage passes to a TAFKAL80ETC concert'
        BackstagePass
      end
    end

    def update_quality
      @item.update_quality
    end
  end

  class Normal
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality = quality
      @sell_in = sell_in
    end

    def update_quality
      if @quality != 0
        @quality -= 1
        @quality -= 1 if @sell_in < 0
      end
      @sell_in -= 1
    end
  end

  class AgedBrie
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality = quality
      @sell_in = sell_in
    end

    def update_quality
      @sell_in -= 1
      @quality += 1
    end
  end

  class Sulfuras
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality = quality
      @sell_in = sell_in
    end

    def update_quality
    end
  end


  class BackstagePass
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality = quality
      @sell_in = sell_in
    end

    def update_quality
      if @sell_in < 0
        @quality = 0
      else
        @quality += 1
        @quality += 1 if @sell_in < 10
        @quality += 1 if @sell_in < 5
      end
          
      @sell_in -= 1
    end
  end
end
