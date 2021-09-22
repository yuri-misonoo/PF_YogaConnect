# frozen_string_literal: true

require 'rails_helper'

describe 'サインイン前のテスト' do
  before do
    visit root_path
  end

  describe '表示の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/'
    end
  end

  describe 'ヘッダーのテスト：ログインしていない場合' do
    context '表示の確認' do
      it 'ホームのリンクが表示される' do
        expect(page).to have_link 'ホーム', href: root_path
      end

      it 'サイトの説明ページのリンクが表示されている' do
        expect(page).to have_link 'サイトについて', href: homes_about_path
      end

      it 'ログインのリンクが表示されている' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end

      it 'サインアップのリンクが表示されています' do
        expect(page).to have_link 'サインアップ', href: new_user_registration_path
      end
    end

    context 'リンクの遷移先を確認' do
      it 'ホームを押すと、トップ画面に遷移する' do
        click_link 'ホーム'
        expect(current_path).to eq('/')
      end

      it 'サイトについてを押すと、about画面に遷移する' do
        click_link 'サイトについて'
        expect(current_path).to eq('/homes/about')
      end

      it 'ログインを押すと、ログイン画面に遷移する' do
        click_link 'ログイン'
        expect(current_path).to eq('/users/sign_in')
      end

      it 'サインアップを押すと、サインアップ画面に遷移する' do
        click_link 'サインアップ'
        expect(current_path).to eq('/users/sign_up')
      end
    end
  end

  describe 'サインアップページのテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end

      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end

      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end

      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end

      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end

      it '新規登録のリダイレクト先が、投稿一覧になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/users/' + User.last.id.to_s + '/new'
      end
    end
  end

  describe 'ログインページのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示の確認' do
      it 'emailのフォームが表示されている' do
        expect(page).to have_field 'user[email]'
      end

      it 'passwordのフォームが表示されている' do
        expect(page).to have_field 'user[password]'
      end
    end

    it 'ログインボタンが表示される' do
      expect(page).to have_button 'ログイン'
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、投稿一覧ページになっている' do
        expect(current_path).to eq '/posts'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'aboutページ' do
    before do
      visit homes_about_path
    end

    context '表示の確認' do
      it 'サイトの説明が表示されているか' do
        expect(page).to have_content 'サイトの説明'
      end

      it '体調管理が表示されているか' do
        expect(page).to have_content '体調管理'
      end

      it 'タイムラインの説明が表示されているか' do
        expect(page).to have_content 'タイムライン'
      end
    end
  end

  describe 'ヘッダーのテスト：ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it '今日の記録のリンクが表示される' do
        expect(page).to have_link '今日の記録', href: new_user_health_log_path(user)
      end

      it '投稿一覧のリンクが表示される' do
        expect(page).to have_link '投稿一覧', href: posts_path
      end

      it '新規投稿のリンクが表示される' do
        expect(page).to have_link '投稿する', href: new_post_path
      end

      it 'マイページのリンクが表示される' do
        expect(page).to have_link 'マイページ', href: user_path(user)
      end

      it 'ログアウトのリンクが表示される' do
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end
    end
  end
end
