require "rails_helper"

# 件数の多いデータを作り、一覧表示と更新を繰り返す重めのリクエストテスト。
RSpec.describe "Tasks (bulk)", type: :request do
  [ 50, 100, 200 ].each do |count|
    context "#{count} 件のタスクがあるとき" do
      before do
        count.times do |i|
          Task.create!(
            title: "task #{i}",
            description: "説明 " * 20,
            status: i % 3,
            due_on: Date.current + (i % 20) - 10
          )
        end
      end

      it "一覧がすべてのタスクを表示する" do
        get tasks_path
        expect(response).to have_http_status(:ok)
        expect(response.body.scan("task ").size).to be >= count
      end

      it "全タスクを順に完了にできる" do
        Task.find_each do |task|
          patch task_path(task), params: { task: { status: "done" } }
          expect(response).to redirect_to(task_path(task))
        end
        expect(Task.where.not(status: :done)).to be_empty
      end

      it "全タスクの詳細ページを表示できる" do
        Task.find_each do |task|
          get task_path(task)
          expect(response).to have_http_status(:ok)
        end
      end

      it "全タスクを順に削除できる" do
        Task.find_each do |task|
          delete task_path(task)
        end
        expect(Task.count).to eq(0)
      end
    end
  end
end
