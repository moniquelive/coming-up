require "test_helper"

class IdeaTest < ActiveSupport::TestCase
  test "invalid" do
    assert_not Idea.new.save
    assert_not Idea.new(title: "Hello World").save
    assert_not Idea.new(title: "Hello World", body: "Rock your body").save
  end

  test "valid" do
    assert_equal true, Idea.new(title: "Hello World", body: "Rock your body", user: User.new).save
  end

  test "updating an idea does not create another star" do
    user = User.new
    idea = Idea.create!(title: "Hello World", body: "Rock your body", user: user)
    assert idea
    assert_equal 1, idea.stars.count
    assert_equal user, idea.stars.first.user

    idea.update(body: "another body")
    assert_equal 1, idea.stars.count
  end
end
