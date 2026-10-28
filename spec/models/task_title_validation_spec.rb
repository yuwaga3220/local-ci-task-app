require "rails_helper"

RSpec.describe Task, "タイトルの長さ検証", type: :model do
  (1..100).each do |length|
    it "#{length} 文字のタイトルは有効" do
      expect(Task.new(title: "a" * length)).to be_valid
    end
  end

  (101..150).each do |length|
    it "#{length} 文字のタイトルは無効" do
      task = Task.new(title: "a" * length)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to be_present
    end
  end
end
