require './gilded_rose.rb'
require "rspec"

describe GildedRose do
  describe '::Normal' do
    before(:each) do
      @item = GildedRose::Normal.new(3, 6)
    end

    describe 'sell_in' do
      it 'should descrease by 1' do
        expect { @item.update_quality }.to change { @item.sell_in }.by(-1)
      end
    end

    describe 'quality' do
      it 'should decrease by 1' do
        expect { @item.update_quality }.to change { @item.quality }.by(-1)
      end

      it 'should never be less than 0' do
        @item = GildedRose::Normal.new(0, 6)
        expect { @item.update_quality }.to change { @item.quality }.by(0)
      end

      context 'passed sell_in date' do
        it 'should decrease quality by 2' do
          @item = GildedRose::Normal.new(10, -4)
          expect { @item.update_quality }.to change { @item.quality }.by(-2)
        end
      end
    end
  end

  describe '::BackstagePass' do
    before(:each) do
      @item = GildedRose::BackstagePass.new(15, 20)
    end

    describe 'sell_in' do
      it 'should decrease by 1' do
        expect { @item.update_quality }.to change { @item.sell_in }.by(-1)
      end
    end

    describe 'quality' do
      it 'should increase by 1' do
        expect { @item.update_quality }.to change { @item.quality }.by(1)
      end

      it 'should increase by 2 when less than 10 days' do
        @item = GildedRose::BackstagePass.new(15, 9)
        expect { @item.update_quality }.to change { @item.quality }.by(2)
      end

      it 'should increase by 3 when less than 5 days' do
        @item = GildedRose::BackstagePass.new(15, 4)
        expect { @item.update_quality }.to change { @item.quality }.by(3)
      end

      it 'becomes 0 after sell_in date' do
        @item = GildedRose::BackstagePass.new(15, -2)
        @item.update_quality
        @item.quality.should == 0
      end
    end
  end

  describe '::Sulfuras' do
    before(:each) do
      @item = GildedRose::Sulfuras.new(2, 0)
    end

    describe 'sell_in' do
      it 'does not change' do
        expect { @item.update_quality }.to change { @item.sell_in }.by(0)
      end
    end

    describe 'quality' do
      it 'should never change' do
        expect { @item.update_quality }.to change { @item.quality }.by(0)
      end
    end
  end

  describe '::AgedBrie' do
    before(:each) do
      @item = GildedRose::AgedBrie.new(2, 0)
    end

    describe 'sell_in' do
      it 'should decrease by 1' do
        expect { @item.update_quality }.to change { @item.sell_in }.by(-1)
      end
    end

    describe 'quality' do
      it 'should increase by 1' do
        expect { @item.update_quality }.to change { @item.quality }.by(1)
      end
    end
  end
end
