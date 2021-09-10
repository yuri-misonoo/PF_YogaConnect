# frozen_string_literal: true

require 'rails_helper'

describe 'userコントローラのテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '目標設定ページ' do
    before do
      visit new_user_path(user)
    end

    context '表示内容のテスト' do
      it 'プロフィール画像のフォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end

      it '紹介文のフォームが表示される' do
        expect(page).to have_field 'user[introduction]'
      end

      it '目標体重のフォームが表示される' do
        expect(page).to have_field 'user[goal_weight]'
      end

      it 'ヨガ実践目標のフォームが表示される' do
        expect(page).to have_field 'user[goal]'
      end

      it '登録ボタンが表示される' do
        expect(page).to have_button '登録'
      end
    end

    context '登録成功のテスト' do
      before do
        fill_in 'user[profile_image]', with: user.profile_image
        fill_in 'user[introduction]', with: user.introduction
        fill_in 'user[goal_weight]', with: user.goal_weight
        fill_in 'user[goal]', with: user.goal
        click_button '登録'
      end
      it '登録後のリダイレクト先が、投稿一覧ページになっている' do
        expect(current_path).to eq '/posts'
      end
    end
  end
  
  describe '詳細ページのテスト' do
    
  end

end