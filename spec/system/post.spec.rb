# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  describe "投稿画面(new_path)のテスト" do
    before do
      visit todolists_new_path
    end
    context '表示の確認' do
      it 'todolists_new_pathが"/todolists/new"であるか' do
        expect(current_path).to eq('/todolists/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'list[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'list[body]', with: Faker::Lorem.characters(number:20)
        click_button '投稿'
        expect(page).to have_current_path todolist_path(List.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit todolists_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content list.title
        expect(page).to have_link list.title
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit todolist_path(list)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/todolists/' + list.id.to_s + '/edit')
      end
    end
    context 'list削除のテスト' do
      it 'listの削除' do
        expect{ list.destroy }.to change{ List.count }.by(-1)
      end
    end
  end