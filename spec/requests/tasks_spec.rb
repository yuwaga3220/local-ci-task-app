require "rails_helper"

RSpec.describe "Tasks", type: :request do
  let!(:task) { Task.create!(title: "既存タスク") }

  it "一覧を表示する" do
    get tasks_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("既存タスク")
  end

  it "タスクを作成する" do
    expect {
      post tasks_path, params: { task: { title: "新規タスク", status: "todo" } }
    }.to change(Task, :count).by(1)
    expect(response).to redirect_to(task_path(Task.last))
  end

  it "タイトルが空だと作成できない" do
    expect {
      post tasks_path, params: { task: { title: "" } }
    }.not_to change(Task, :count)
    expect(response).to have_http_status(:unprocessable_content)
  end

  it "タスクを更新する" do
    patch task_path(task), params: { task: { status: "done" } }
    expect(task.reload).to be_done
  end

  it "タスクを削除する" do
    expect { delete task_path(task) }.to change(Task, :count).by(-1)
  end
end
