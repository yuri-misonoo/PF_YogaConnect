# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '70文字以下であること: 70文字は〇' do
        user.introduction = Faker::Lorem.characters(number: 70)
        is_expected.to eq true
      end
      it '50文字以下であること: 71文字は×' do
        user.introduction = Faker::Lorem.characters(number: 71)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'HealthLogモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(User.reflect_on_association(:health_logs).macro).to eq :has_many
      end
    end

    context 'PostCommentモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'UserRoomモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end

    context 'Chatモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(User.reflect_on_association(:chats).macro).to eq :has_many
      end
    end

    context 'Roomモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(User.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it 'reverse_of_relationshipと1:Nの関係になっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end

      it 'relationshipと1:Nの関係になっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end

      it 'followerと1:Nの関係になっている' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end

      it ':followingと1:Nの関係になっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end

  end
end