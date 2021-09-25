# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, body: 'abcdefghijk', user: user) }
  let(:other_post) { create(:post, body: 'lmnopqrstuvwxyz', user: other_user) }
  let(:post_comment) { create(:post, :user, body: 'dghtueksmlejp') }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe "投稿画面(new_post_path)のテスト" do
    before do
      visit new_post_path
    end

    context '表示の確認' do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end

      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end

      it '投稿フォームはあるか' do
        expect(page).to have_field 'post[body]'
      end
    end

    context '投稿処理のテスト' do
      before do
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 50)
      end

      it '投稿が正しく保存されるか' do
        expect { click_button '投稿' }.to change(user.posts, :count).by(1)
      end

      it '投稿後のリダイレクト先は正しいか' do
        click_button '投稿'
        expect(page).to have_current_path posts_path
      end
    end
  end

  describe "投稿一覧のテスト" do
    before(:each) do
      @post = create(:post, body: 'abcdefghijk', user: user)
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end

      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link post.user.profile_image, href: user_path(post.user)
      end

      it 'いいねの数が表示される' do
        expect(page).to have_content @post.favorites.count
      end

      it 'コメント数が表示される' do
        expect(page).to have_content @post.post_comments.count
      end

      it '自分の投稿に投稿編集画面へのボタンが表示され、リンクが存在している' do
        # expect(page).to have_button '編集'
        expect(page).to have_link '編集', href: edit_post_path(@post)
      end

      it '自分の投稿に削除ボタンが表示される' do
        expect(page).to have_link '削除', href: post_path(@post)
      end
    end

    context '投稿削除のテスト' do
      it '正しく削除される' do
        click_link '削除'
        expect { @post.destroy }.to change { Post.count }.by(0)
      end

      it 'リダイレクト先が投稿一覧になっている' do
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit post_path(post)
    end

    context '表示の確認' do
      it '削除ボタンが存在しているか' do
        expect(page).to have_link '削除'
      end

      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end

      it 'いいねの数が表示される' do
        expect(page).to have_content post.favorites.count
      end

      it 'コメント数が表示される' do
        expect(page).to have_content post.post_comments.count
      end
    end

    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        click_link '編集'
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end

    context '投稿削除のテスト' do
      it '投稿の削除' do
        click_link '削除'
        expect { post.destroy }.to change { Post.count }.by(0)
      end
    end

    context '新規コメントの表示のテスト' do
      it 'コメントのフォームが存在するか' do
        expect(page).to have_field 'post_comment[body]'
      end

      it 'コメントの送信ボタンが存在しているか' do
        expect(page).to have_button '送信'
      end
    end

    context 'コメント成功のテスト' do
      before do
        fill_in 'post_comment[body]', with: Faker::Lorem.characters(number: 30)
        click_button '送信'
      end

      it '送信後に投稿詳細ページにレンダーされるか' do
        #expect(current_path).to eq '/post/' + post.id.to_s
        #expect(response).to render_template(:show)
        #p show.html
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end

      it 'body編集フォームが表示されている' do
        expect(page).to have_field 'post[body]', with: post.body
      end

      it '詳細ページへのリンクが表示されている' do
        expect(page).to have_link '詳細へ', href: post_path(post)
      end

      it '一覧ページへのリンクが表示されている' do
        expect(page).to have_link '一覧へ', href: posts_path
      end
    end

    context '更新処理のテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 50)
        click_button '更新'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end
