require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/star.png')
  end

  describe '出品機能' do
    context '出品ができる時' do
      it "必須項目が全てあれば登録できること" do
        expect(@item).to be_valid
      end
      it 'ログイン状態のユーザーのみ、商品出品ページへ遷移できること' do
        @item = FactoryBot.create(:user)
        expect(@item).to be_valid
      end
    end


    context '出品ができない時' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image.key = ''
        @item.valid?
        expect(@item.errors.full_messages).to include{"Image can't be blank"}
      end

      it '商品名が必須であること' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態についての情報が必須であること' do
        @item.product_condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition can't be blank")
      end

      it '配送料の負担についての情報が必須であること' do
        @item.shipping_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it '発送元の地域についての情報が必須であること' do
        @item.shipment_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment area can't be blank")
      end

      it '発送までの日数についての情報が必須であること' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '売価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = '100'
        @item.valid?
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = "２０００"
        @item.valid?
      end
    end
  end
end
