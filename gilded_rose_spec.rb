require './gilded_rose.rb'
require "rspec"

describe GildedRose do
  describe 'handle normal items' do
    before(:each) do
      items = subject.items([Item.new("Conjured Mana Cake", 3, 6)])
      @item = items.first
    end

    describe 'sell_in' do
      it 'should descrease by 1' do
        expect { subject.update_quality }.to change { @item.sell_in }.by(-1)
      end
    end

    describe 'quality' do
      it 'should decrease by 1' do
        expect { subject.update_quality }.to change { @item.quality }.by(-1)
      end

      it 'should never be less than 0' do
        @item.quality = 0
        expect { subject.update_quality }.to change { @item.quality }.by(0)
      end

      context 'passed sell_in date' do
        it 'should decrease quality by 2' do
          @item.sell_in = -4
          expect { subject.update_quality }.to change { @item.quality }.by(-2)
        end
      end
    end
  end

  describe 'Backstage, passes, to a TAFKAL80ETC concert' do
    before(:each) do
      items = subject.items([Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)])
      @item = items.first
    end

    describe 'sell_in' do
      it 'should decrease by 1' do
        expect { subject.update_quality }.to change { @item.sell_in }.by(-1)
      end
    end

    describe 'quality' do
      it 'should increase by 1' do
        expect { subject.update_quality }.to change { @item.quality }.by(1)
      end

      it 'should increase by 2 when less than 10 days' do
        @item.sell_in = 9
        expect { subject.update_quality }.to change { @item.quality }.by(2)
      end

      it 'should increase by 3 when less than 5 days' do
        @item.sell_in = 4
        expect { subject.update_quality }.to change { @item.quality }.by(3)
      end

      it 'becomes 0 after sell_in date' do
        @item.sell_in = -2
        subject.update_quality
        @item.quality.should == 0
      end
    end
  end

  describe 'Sulfuras, Hand of Ragnaros' do
    before(:each) do
      items = subject.items([Item.new("Sulfuras, Hand of Ragnaros", 0, 80)])
      @item = items.first
    end

    describe 'sell_in' do
      it 'does not change' do
        expect { subject.update_quality }.to change { @item.sell_in }.by(0)
      end
    end

    describe 'quality' do
      it 'should never change' do
        expect { subject.update_quality }.to change { @item.quality }.by(0)
      end
    end
  end

  describe 'Aged Brie' do
    before(:each) do
      items = subject.items([Item.new("Aged Brie", 2, 0)])
      @item = items.first
    end

    describe 'sell_in' do
      it 'should decrease by 1' do
        expect { subject.update_quality }.to change { @item.sell_in }.by(-1)
      end
    end

    describe 'quality' do
      it 'should increase by 1' do
        expect { subject.update_quality }.to change { @item.quality }.by(1)
      end
    end
  end
end
