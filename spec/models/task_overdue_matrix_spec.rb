require "rails_helper"

# ステータス × 期限日のオフセットの全組み合わせで、overdue の判定を検証する。
# 件数を増やす目的で、現実のテストでよくあるパラメータ化テストの形にしている。
RSpec.describe Task, "overdue の判定マトリクス", type: :model do
  Task.statuses.each_key do |status|
    (-30..30).each do |offset|
      it "status=#{status}, 期限=今日#{offset >= 0 ? "+" : ""}#{offset}日" do
        task = Task.create!(title: "matrix", status: status, due_on: Date.current + offset)
        expected = status != "done" && offset < 0

        expect(Task.overdue.exists?(task.id)).to eq(expected)
      end
    end
  end
end
