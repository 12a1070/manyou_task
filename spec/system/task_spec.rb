
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task') }
  before do
    @task1 = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # タスクを新規作成したとき、作成したタスクが画面に表示される
        visit new_task_path
        # name欄に空欄以外を通したい
        fill_in 'task[name]',with: 'あ'
        # content欄に空欄以外を通す
        fill_in 'task[content]',with: 'あ'
        # Create Taskを押した時に
        click_button 'Create Task'
        # コンテントの文字が入っている時だけしたい
        expect(page).to have_content 'あ'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      # 一覧画面では、作成済みのタスクが表示される
        visit tasks_path
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
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
      # expect(page).to have_content 'task_title'
      task =FactoryBot.create(:task, name: 'task', content: 'task')
      visit task_path(@task1.id)
      expect(page).to have_content 'タイトル１'
      # 任意のタスク詳細画面に遷移したとき、該当タスクの内容が表示される
      end
    end
  end
end
