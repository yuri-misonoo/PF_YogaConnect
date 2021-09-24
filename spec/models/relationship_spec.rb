require 'rails_helper'

RSpec.describe Relationship, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:relationship) { FactoryBot.create(:relationship) }

  describe 'フォローのテスト' do
    context '保存できる場合' do
      it '全てのパラメーターがそろっている' do
        expect(relationship).to be_valid
      end
    end

    context '保存できない場合' do
      it 'follower_idがnilの場合は保存できない' do
        relationship.follower_id = nil
        relationship.valid?
      end
    end
  end

end
