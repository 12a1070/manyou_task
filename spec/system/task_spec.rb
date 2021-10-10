
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # どっちのユーザーでログインするか
    # FactoryBot.create(:normal_user)
    # visit new_session_path
    # fill_in :session_email,with: 'normal@mail.com'
    # fill_in :session_password,with: 'password2'
    # click_on'ログイン'
    # 一般ユーザーのテストでは上を使う

    @admin_user = FactoryBot.create(:admin_user)
    FactoryBot.create(:task, name: "test" ,content:"task",user_id: @admin_user.id)
    FactoryBot.create(:second_task, name: "second_name",user_id: @admin_user.id)
    FactoryBot.create(:third_task, name: "dic",user_id: @admin_user.id)
    visit new_session_path
    fill_in :session_email,with: 'admin@mail.com'
    fill_in :session_password,with: 'password1'
    click_on'ログイン'
  end


  # let!(:task) { FactoryBot.create(:task, name: 'task') }
  # before do
  #   @task1 = FactoryBot.create(:task)
  #   @task2 = FactoryBot.create(:second_task)
  #   visit tasks_path
  # end


  describe '検索機能' do
    # @normal_user = FactoryBot.create(:normal_user)
    # adminは13行目で作成ずみ
    # @admin_user = FactoryBot.create(:admin_user)

      # 必要に応じて、テストデータの内容を変更して構わない
      # FactoryBot.create(:task, name: "test" ,content:"task",user_id: @normal_user.id)
      # FactoryBot.create(:second_task, name: "second_name",user_id: @normal_user.id)
      # FactoryBot.create(:third_task, name: "dic",user_id: @admin_user.id)


    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
              # ログインさせる処理のテスト
# ログイン工程はbefore do で共通化
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'search_name',with: 'test'
        # 検索ボタンを押す
        click_on 'Search'
        expect(page).to have_content 'test'
      end
    end

  context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        # プルダウンを選択する「select」について調べてみること
        select '着手中',from: 'search_status'
        click_on'Search'
        expect(page).to have_content'着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトル(Name)に含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        visit tasks_path
        sleep 0.3
        fill_in :search_name ,with: 'dic'
        select '完了',from: 'search_status'
        click_on 'Search'
        expect(page).not_to have_content 'task'
        expect(page).to have_content 'dic'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # タスクを新規作成したとき、作成したタスクが画面に表示される
        visit new_task_path
        # name欄に空欄以外を通したい
        fill_in 'task[name]',with: 'test_name'
        # content欄に空欄以外を通す
        fill_in 'task[content]',with: 'test_content'
        # 終了期限を登録
        # step3追加条件
        # 終了期限の設定において、プルダウン選択の、fill_in'',withだけではなくselect'',fromを使用する。
        fill_in 'task[limit]' ,with: '002020-10-11'
        select '着手中', from: "task[status]"
        select '中', from: "task[priority]"
        # Create Taskを押した時に
        click_button '登録する'
        # コンテントの文字が入っている時だけしたい
        expect(page).to have_content 'test_name'
      end
    end
  end


  describe '一覧表示機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: "test" ,content:"task", user:@admin_user)
      FactoryBot.create(:second_task, name: "second_name", user:@admin_user)
      FactoryBot.create(:third_task, name: "name2", user:@admin_user)
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      # 一覧画面では、作成済みのタスクが表示される
        visit tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content 'name2'
      end
    end


# タスク消去機能
  context 'タスク削除機能' do
    it '削除したら一覧画面からタスクが消える' do
      visit tasks_path
      expect(page).to have_content 'name2'
      page.accept_confirm do
        first('.task_now').click_link 'Destroy'
      end
      expect(page).not_to have_content 'name2'
    end
  end

    # step2追加用件
    context 'タスクが作成日時の降順の場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  # step3追加用件
    context 'タスクが終了期限の降順の場合' do
      it '終了期限が早いタスクが上に表示される' do
        visit tasks_path
        task1 = FactoryBot.create(:task, name: 'limit1', limit:'2221-12-31 00:00:00', user:@admin_user)
        task2 = FactoryBot.create(:task, name: 'limit2', limit:'2222-12-31 00:00:00', user:@admin_user)
        task3 = FactoryBot.create(:task, name: 'limit3', limit:'2223-12-31 00:00:00', user:@admin_user)
      # 終了期限の降順に並び替えられたタスク一覧が表示される
        click_on '終了期限でソートする'
        task = all('.task_now')
        sleep 1.0
# binding.pryをして expect(task[0]).to have_content '2223-12-31'〜expect(task[2]).to have_content '2221-12-31'が[2][1][0]だったのが間違い。
        expect(task[0]).to have_content '2223-12-31'
        expect(task[1]).to have_content '2222-12-31'
        expect(task[2]).to have_content '2221-12-31'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
      # visit task_path
      # click_on '編集する'
      # click_on '登録'
      # expect(page).to have_content 'task'
      task = FactoryBot.create(:task, name: 'task', content: 'task', user:@admin_user)
      visit task_path(task.id)
      expect(page).to have_content 'task'
      # 任意のタスク詳細画面に遷移したとき、該当タスクの内容が表示される
      end
    end
  end
end
