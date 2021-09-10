# frozen_string_literal: true

require 'rails_helper'

describe 'userコントローラのテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, body: 'abcdefghijk', user: user) }
  let(:other_post) { create(:other_post, body: 'abcdefghijk', user: user) }

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

  describe 'マイページのテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      #it 'URLが正しい' do
        #expect(page).to eq('/users/' + user.id.to_s)
      #end

      it '今日の記録のリンクが表示される' do
        expect(page).to have_link '今日の記録', href: new_user_health_log_path(user)
      end

      it '記録一覧のリンクが表示される' do
        expect(page).to have_link '記録一覧', href: user_health_logs_path(user)
      end

      it 'ヨガ実践カレンダーのリンクが表示される' do
        expect(page).to have_link 'ヨガ実践カレンダー', href: user_health_logs_calender_path(user)
      end

      it '編集画面へのリンクが表示される' do
        expect(page).to have_link '編集', href: edit_user_path(user)
      end

      it '退会のリンクが表示される' do
        expect(page).to have_link '退会', href: user_path(user)
      end

      it '自分の名前が表示される' do
        expect(page).to have_content user.name
      end

      it '自分の紹介文が表示される' do
        expect(page).to have_content user.introduction
      end

      it '自分の投稿数が表示される' do
        expect(page).to have_content user.posts.count
      end

      it '自分の投稿一覧が表示される' do
        expect(page).to have_content user.posts
      end
    end
  end
  
  describe 'ユーザー情報編集画面のテスト' do
    before do 
      visit edit_user_path(user)
    end
    
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      
      it '画像編集フォームが表示されるか' do
        expect(page).to have_field 'user[profile_image]', with: user.profile_image
      end
      
      it 'ニックネーム編集フォームが表示される' do
        expect(page).to have_field 'user[name]', with: user.name 
      end
      
      it '自己紹介文の編集フォームが表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      
      it '目標体重の編集フォームが表示される' do
        expect(page).to have_field 'user[goal_weight]', with: user.goal_weight
      end
      
      it 'ヨガ実践目標のフォームが表示される' do
        expect(page).to have_field 'user[goal]', with: user.goal
      end
    end
  end

end