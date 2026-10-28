require "rails_helper"

RSpec.describe "タスク操作（ブラウザ）10", type: :system do
  (90...100).each do |i|
    it "タスク #{i} を作成して一覧で確認し、完了にして削除できる" do
      visit new_task_path
      fill_in "Title", with: "ブラウザタスク #{i}"
      select "doing", from: "Status"
      click_button "Create Task"
      expect(page).to have_content("Task was successfully created")

      visit tasks_path
      expect(page).to have_content("ブラウザタスク #{i}")

      click_link "Show this task"
      click_link "Edit this task"
      select "done", from: "Status"
      click_button "Update Task"
      expect(page).to have_content("Task was successfully updated")

      click_button "Destroy this task"
      expect(page).to have_content("Task was successfully destroyed")
      expect(Task.count).to eq(0)
    end
  end
end
