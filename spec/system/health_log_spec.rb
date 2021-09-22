# frozen_string_literal: true

require 'rails_helper'

describe '記録のテスト' do
  let(:user) { create(:user) }
  let(:health_log) { create(:health_log, weight: '50', temperature: '36', exercise: 'ヨガ', morning: 'ご飯', lunch: 'ラーメン', dinner: 'カレー', memo: 'がんばった', user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '記録ページのテスト' do
    before do
      visit new_user_health_log_path(user)
    end

    context '表示の確認' do
      it 'URLの確認' do
        expect(current_path).to eq('/users/' + user.id.to_s + '/health_logs/new')
      end

      it '体重のフォームが表示される' do
        expect(page).to have_field 'health_log[weight]'
      end

      it '体温のフォームが表示される' do
        expect(page).to have_field 'health_log[temperature]'
      end

      it '元気度のフォームが表示される' do
        expect(page).to have_field 'health_log[feeling]'
      end

      it '運動してかどうかを入力するフォームが表示される' do
        expect(page).to have_field 'health_log[is_active]'
      end

      it 'ヨガ実践内容のフォームが表示される' do
        expect(page).to have_field 'health_log[exercise]'
      end

      it '朝食のフォームが表示される' do
        expect(page).to have_field 'health_log[morning]'
      end

      it '昼食のフォームが表示される' do
        expect(page).to have_field 'health_log[lunch]'
      end

      it '夕食のフォームが表示される' do
        expect(page).to have_field 'health_log[dinner]'
      end

      it '今日のメモのフォームが表示される' do
        expect(page).to have_field 'health_log[memo]'
      end

      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end

    context '内容が正しく保存される' do
      before do
        fill_in 'health_log[weight]', with: health_log.weight
        fill_in 'health_log[temperature]', with: health_log.temperature
        fill_in 'health_log[exercise]', with: health_log.exercise
        fill_in 'health_log[morning]', with: health_log.morning
        fill_in 'health_log[lunch]', with: health_log.lunch
        fill_in 'health_log[dinner]', with: health_log.dinner
        fill_in 'health_log[memo]', with: health_log.memo
        click_button '保存'
      end

      it '登録後のリダイレクト先が記録の詳細ページになっている' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/health_logs/' + HealthLog.last.id.to_s
      end
    end
  end
end
