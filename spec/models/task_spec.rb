require "rails_helper"

RSpec.describe Task, type: :model do
  describe "validations" do
    it "タイトルがあれば有効" do
      expect(Task.new(title: "牛乳を買う")).to be_valid
    end

    it "タイトルが空なら無効" do
      expect(Task.new(title: "")).not_to be_valid
    end

    it "タイトルが 101 文字以上なら無効" do
      expect(Task.new(title: "a" * 101)).not_to be_valid
    end
  end

  describe "status" do
    it "既定値は todo" do
      expect(Task.new(title: "x")).to be_todo
    end
  end

  describe ".overdue" do
    it "期限切れで未完了のタスクだけ返す" do
      late = Task.create!(title: "late", due_on: Date.current - 1)
      Task.create!(title: "done", due_on: Date.current - 1, status: :done)
      Task.create!(title: "future", due_on: Date.current + 1)

      expect(Task.overdue).to contain_exactly(late)
    end
  end
end
