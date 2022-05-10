require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、first_name、last_name、first_name_k、last_name_k、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end


    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      
      it 'passwordが数字だけだと登録できない' do
        @user.password ='11111111'
        @user.password_confirmation = '11111111'
        @user.valid?
      end

      it 'passwordが英字だけだと登録できない' do
        @user.password = 'aaaaaaaa'
        @user.password_confirmation = 'aaaaaaaa'
        @user.valid?
        end

        it 'passwordが全角だと登録できない' do
          @user.password = 'ああああああ'
          @user.password_confirmation = 'ああああああ'
          @user.valid?
        end


      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

        it "last_nameが空では登録できない" do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end

        it "first_nameが空では登録できない" do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it "last_name_kが空では登録できない" do
          @user.last_name_k = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name k can't be blank")
        end

        it "first_name_kが空では登録できない" do
          @user.first_name_k = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name k can't be blank")
        end

        it 'first_nameが半角では登録できない' do
          @user.first_name = 'aaaa'
          @user.valid?
        end

        it 'last_nameが半角では登録できない' do
          @user.last_name = 'aaaa'
          @user.valid?
        end

        it 'first_name_kが半角では登録できない' do
          @user.first_name_k = 'aaaa'
          @user.valid?
        end

        it 'last_name_kが半角では登録できない' do
          @user.first_name_k = 'aaaa'
          @user.valid?
        end

        it 'first_name_kがカナ以外では登録できない' do
          @user.first_name_k = 'やまだ'
          @user.valid?
        end

        it 'last_name_kがカナ以外では登録できない' do
          @user.first_name_k = 'たろう'
          @user.valid?
        end

        it "birthdayが空では登録できない" do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
    end
  end
end
