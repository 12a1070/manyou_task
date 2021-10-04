reqire 'rails_helper'
RSpec.describe 'ユーザー管理システム', type: :system do

  def login_admin
    visit new_session_path
    fill_in 'session[email]', with:'admin@'mail.com'
    fill_in 'session[password_digest]'with:'password1'
    lick_button 'Log in'
  end


  def login
    visit new_session_path
    fill_in 'session[email]', with: 'normal@mail.com'
    fill_in 'session[password_digest]',with:'password2'
    click_button 'Log in'
  end


  describe 'ユーザー登録テスト' do
    context 'ユーザーのデータが0でログインしていないとき' do
      it 'ユーザー登録が可能' do
        visit new_user_path
        fill_in 'user[name]', with: 'normal_name'
        fill_in 'user[email', with: 'normal@mail.com'
        fill_in 'user[password_digest]', with: 'password2'
        fill_in 'user[password_digest_confirmation]', with: 'password2'
        click_btton 'Create my account'
        expect(page).to have_content 'normal@mail.com'
      end

      it 'ログインしてない時はログイン画面に遷移' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end


  describe 'セッション機能テスト' do
    before do
      @normal_user = FactoryBot.create(:normal_user)
    end

    context 'ユーザーのデータは存在していてログインしていないとき' do
      it 'ログイン可能' do
        visit new_session_path
        fill_in 'session[email]', with: 'normal@mail.com'
        fill_in 'session[password_digest]', with:'password2'
        click_button 'log in'
        expect(current_path).to eq user_path(id: @normal_user.id)
      end
    end

    context 'ユーザーのデータが存在していてログイン状態の時'  do
      it 'マイページに飛ぶ' do
        login
        visit user_path(id: @normal_user.id)
        expect(current_path).to eq user_path(id: @normal_user.id)
      end

      it'一般ユーザーが他人の詳細画面に飛ぶとタスク一覧に遷移' do
        login
        @admin_user = FactoryBot.create(:admin_user)
        visit user_path(id: @admin_user.id)
        expect(page).to have_content "管理者権限を持っていません"
      end


      it 'ログアウトできる' do
        login
        visit user_path(id: @normal_user.id)
        click_on 'ログアウト'
        expect(page).to have_content "ログアウトしました"
      end
    end
  end


  describe '管理画面テスト' do
    before do
      @normal_user = FactoryBot.create(:normal_user)
      @admin_user = FactoryBot.create(:admin_user)
    end

    context '一般ユーザでログインしている場合' do
      it '管理ページにアクセスできない' do
        login
        visit admin_users_path
        expect(page).to have_content "管理者以外のアクセスはできません"
      end
    end

    it '管理画面にアクセスできる' do
      visit admin_users_path
      expect(page).to have_content "タスクユーザー一覧"
    end

    it '管理者はユーザーの新規登録が可能' do
      visit admin_users_path
      click_on '新規ユーザー登録'
      fill_in 'user[name]',with: 'normal_user'
      fill_in 'user[email]',with: 'normal@mail.com'
      fill_in 'user[password_digest]',with:'password2'
      fill_in 'user[password_digest_confirmation]',with:'password2'

    end

  end


end
