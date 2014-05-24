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


  def items(items)
    @items = items
  end

  def update_quality
    for i in 0..(@items.size-1)
      case @items[i].name
      when '+5 Dexterity Vest', 'Elixir of the Mongoose', 'Conjured Mana Cake'
        handle_normal_item(@items[i])
      when 'Aged Brie'
        handle_aged_brie(@items[i])
      when 'Sulfuras, Hand of Ragnaros'
        handle_sulfuras(@items[i])
      when 'Backstage passes to a TAFKAL80ETC concert'
        handle_backstage_passes(@items[i])
      end
    end
  end

  def handle_normal_item(item)
    if item.quality != 0
      item.quality -= 1
      item.quality -= 1 if item.sell_in < 0
    end
    item.sell_in -= 1
  end

  def handle_aged_brie(item)
    item.sell_in -= 1
    item.quality += 1
  end

  def handle_sulfuras(item)
  end

  def handle_backstage_passes(item)
    if item.sell_in < 0
      item.quality = 0
    else
      item.quality += 1
      item.quality += 1 if item.sell_in < 10
      item.quality += 1 if item.sell_in < 5
    end
        
    item.sell_in -= 1
  end

end
