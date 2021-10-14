

require 'rails_helper'
RSpec.describe 'ユーザー管理システムのテスト', type: :system do

  describe 'ユーザー登録テスト' do
    context 'ユーザーの新規登録が可能である' do
      it 'ユーザーの新規登録テスト' do
        # 【テストの処理（〇〇になることを期待する）】
        visit new_user_path
        fill_in 'user[name]', with: 'test2@mail.com'
        fill_in 'user[email]', with: 'test2@mail.com'
        fill_in 'user[password]', with: 'test2@mail.com'
        fill_in 'user[password_confirmation]', with: 'test2@mail.com'
        click_button 'Create my account'
        expect(page).to have_content 'test2@mail.com'
      end
      it 'ログインしてない時はログイン画面に飛ぶ' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end


  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:normal_user)
      # @admin_user = FactoryBot.create(:admin_user)
    end
    context 'ユーザーのデータが存在していてログインしていない時' do
      it 'ログイン可能である' do
        visit new_session_path
# ## FactoryBotで作ったからnormalやadminは使えない。別のユーザーに
        fill_in 'session[email]', with: 'test2@mail.com'
        fill_in 'session[password]',with: 'test2@mail.com'
        click_button 'ログイン'
        expect(current_path).to eq user_path(id: @user.id)
      end
    end

    context 'ユーザーのデータが存在していてログインしているとき' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'test2@mail.com'
        fill_in 'session[password]',with:'test2@mail.com'
        click_on 'ログイン'
      #   # ログインしている前提になっている
      end

      it 'マイページに遷移する' do
        visit user_path(@user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end

      it '一般ユーザーが他のユーザーの詳細画面に飛ぶとタスク一覧ページに遷移する' do |variable|
        @user2 = User.create(name: "terai", email: "terai@gmail.com",password: "terai@gmail.com", password_confirmation: "terai@gmail.com")
        visit user_path(id: @user2.id)
# binding.irb
        # 今のままだとid:13のユーザーがid:14のページに飛べている。アクセス制限が必要になる。
        # 一般ユーザにとって違うユーザーである管理者のタスク一覧に行く
        expect(page).to have_content '他人のページへアクセスはできません'
      end

      it 'ログアウト可能である' do
        visit user_path(id: @user.id)
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end


  describe '管理画面のテスト' do
    context '管理者がいないとき' do
      it '管理者は管理画面にアクセスできる' do
        @first_admin = FactoryBot.create(:admin_user, name: "admin_user1", email: "admin_test@test.com")
        visit new_session_path
        fill_in 'session[email]', with: @first_admin.email
        fill_in 'session[password]', with: @first_admin.password
        click_on 'ログイン'
        visit admin_users_path
        expect(page).to have_content 'true'
      end
    end


    context '一般ユーザーでログインしているとき' do
      it '一般ユーザーは管理者画面に入れない' do
        FactoryBot.create(:normal_user)
        visit new_session_path
        fill_in 'session[email]', with:'test2@mail.com'
        fill_in 'session[password]', with:'test2@mail.com'
        click_on 'ログイン'
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセス不可です"
      end
    end


    context '管理者でログインしている場合' do
      before do
        @admin_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin1@example.com'
        fill_in 'session[password]', with: 'admin1@example.com'
        click_on 'ログイン'
        visit admin_users_path
      end

      it '管理者はユーザーの新規登録ができる' do
        click_on "新規ユーザー登録"
        fill_in 'user[name]', with: 'test@mail.com'
        fill_in 'user[email]', with: 'test@mail.com'
        fill_in 'user[password]', with: 'test@mail.com'
        fill_in 'user[password_confirmation]', with: 'test@mail.com'
        click_on '登録'
        expect(page).to have_content 'test@mail.com'
      end

      it '管理者はユーザーの詳細画面にアクセスできる' do
        # @user = FactoryBot.create(:admin_user)
        visit admin_users_path
        click_on "Show"
        expect(page).to have_content 'プロフィール情報'
      end

      it '管理者はユーザーの編集画面からユーザーを編集できる' do
        # @user = FactoryBot.create(:admin_user)
        visit edit_admin_user_path(id: @admin_user.id)
        fill_in 'user[name]', with: 'test@mail.com'
        fill_in 'user[email]', with: 'test@mail.com'
        fill_in 'user[password]', with: 'test@mail.com'
        fill_in 'user[password_confirmation]', with: 'test@mail.com'
        click_on '更新'
        expect(page).to have_content 'test@mail.com'
      end

      it'管理者はユーザーの削除ができる' do
        # @user = FactoryBot.create(:admin_user)
        visit admin_users_path
        click_on 'Destroy', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '管理者がいなくなるので削除できません'
      end

    end
  end
end
