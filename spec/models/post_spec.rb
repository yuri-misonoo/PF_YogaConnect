# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        is_expected.to eq false
      end
      it '5文字以上であること：9文字は×' do
        post.body = Faker::Lorem.characters(number: 4)
        is_expected.to eq false
      end
      it '5文字以上であること：10文字は〇' do
        post.body = Faker::Lorem.characters(number: 5)
        is_expected.to eq true
      end
      it '150文字以内であること：151文字は×' do
        post.body = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
      it '150文字以内であること：150文字は〇' do
        post.body = Faker::Lorem.characters(number: 150)
        is_expected.to eq true
      end
    end
  end
end
