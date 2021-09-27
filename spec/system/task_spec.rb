
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do


  # let!(:task) { FactoryBot.create(:task, name: 'task') }
  # before do
  #   @task1 = FactoryBot.create(:task)
  #   @task2 = FactoryBot.create(:second_task)
  #   visit tasks_path
  # end


  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: "八神")
      FactoryBot.create(:second_task, name: "dic")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'search',with: 'dic'
        # 検索ボタンを押す
        expect(page).to have_content 'dic'
      end
    end

  context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit task_path
        # プルダウンを選択する「select」について調べてみること
        select '着手',from: 'search_status'
        click_on'search'
        expect(page).to have_content'着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        visit task_path
        fill_in '着手',from: 'seach_status'
        click_on 'search'
        expect(page).to have_content 'test_title'
        expect(page).to have_content '着手中'
      end
    end
  end

  # describe '新規作成機能' do
  #   context 'タスクを新規作成した場合' do
  #     it '作成したタスクが表示される' do
  #       # タスクを新規作成したとき、作成したタスクが画面に表示される
  #       visit new_task_path
  #       # name欄に空欄以外を通したい
  #       fill_in 'task[name]',with: 'あ'
  #       # content欄に空欄以外を通す
  #       fill_in 'task[content]',with: 'あ'
  #       # 終了期限を登録
  #       fill_in 'task[limit]' ,with: '002020-10-11'
  #       # Create Taskを押した時に
  #       click_button '登録する'
  #       # コンテントの文字が入っている時だけしたい
  #       expect(page).to have_content 'あ'
  #     end
  #   end
  # end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      # 一覧画面では、作成済みのタスクが表示される
        visit tasks_path
        expect(page).to have_content 'name'
        expect(page).to have_content 'name２'
      end
    end
    context 'タスクが作成日時の降順の場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
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
      task = FactoryBot.create(:task, name: 'task', content: 'task')
      visit task_path(task.id)
      expect(page).to have_content 'task'
      # 任意のタスク詳細画面に遷移したとき、該当タスクの内容が表示される
      end
    end
  end
end
