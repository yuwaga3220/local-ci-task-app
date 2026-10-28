require "rails_helper"

# シナリオ 4 用: 必ず失敗するテスト
RSpec.describe "always fail" do
  it "fails" do
    expect(1).to eq(2)
  end
end
