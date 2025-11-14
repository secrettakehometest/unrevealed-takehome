require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # Test validations
  test "should require title" do
    task = Task.new(description: "Some description", status: "pending")
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "should be valid with title" do
    task = Task.new(title: "Valid Task", description: "Some description")
    assert task.valid?
  end

  test "should reject title longer than 255 characters" do
    task = Task.new(title: "a" * 256, description: "Some description")
    assert_not task.valid?
    assert_includes task.errors[:title], "is too long (maximum is 255 characters)"
  end

  test "should accept title with exactly 255 characters" do
    task = Task.new(title: "a" * 255, description: "Some description")
    assert task.valid?
  end

  test "should reject description longer than 10000 characters" do
    task = Task.new(title: "Valid Task", description: "a" * 10_001)
    assert_not task.valid?
    assert_includes task.errors[:description], "is too long (maximum is 10000 characters)"
  end

  test "should accept description with exactly 10000 characters" do
    task = Task.new(title: "Valid Task", description: "a" * 10_000)
    assert task.valid?
  end

  test "should accept empty description" do
    task = Task.new(title: "Valid Task", description: "")
    assert task.valid?
  end

  # Test enum
  test "should accept valid status values" do
    task = Task.new(title: "Test Task")
    
    task.status = "pending"
    assert task.valid?
    
    task.status = "in_progress"
    assert task.valid?
    
    task.status = "completed"
    assert task.valid?
  end

  # Test callbacks
  test "should set default status to pending" do
    task = Task.new(title: "Test Task")
    task.valid?
    assert_equal "pending", task.status
  end

  test "should not override existing status" do
    task = Task.new(title: "Test Task", status: "in_progress")
    task.valid?
    assert_equal "in_progress", task.status
  end

  # Test scopes
  test "recent scope should order by created_at desc" do
    old_task = tasks(:one)
    new_task = Task.create!(title: "New Task", status: "pending")
    
    recent_tasks = Task.recent
    assert_equal new_task.id, recent_tasks.first.id
  end

  test "by_status scope should filter by status" do
    pending_tasks = Task.by_status("pending")
    assert pending_tasks.all? { |t| t.status == "pending" }
  end

  test "by_status scope should return all when status is blank" do
    all_tasks = Task.by_status("")
    assert_equal Task.count, all_tasks.count
  end

  test "by_status scope should return all when status is nil" do
    all_tasks = Task.by_status(nil)
    assert_equal Task.count, all_tasks.count
  end

  test "search_by_title scope should find tasks by title" do
    results = Task.search_by_title("Searchable")
    assert results.any? { |t| t.title.include?("Searchable") }
  end

  test "search_by_title scope should be case insensitive" do
    results = Task.search_by_title("searchable")
    assert results.any? { |t| t.title.include?("Searchable") }
  end

  test "search_by_title scope should return none when query is blank" do
    results = Task.search_by_title("")
    assert_equal 0, results.count
  end

  test "search_by_title scope should return none when query is nil" do
    results = Task.search_by_title(nil)
    assert_equal 0, results.count
  end

  test "search_by_title scope should trim whitespace" do
    task = Task.create!(title: "Test Task", status: "pending")
    results = Task.search_by_title("  test  ")
    assert results.include?(task)
  end

  test "search_by_title scope should reject queries longer than 255 characters" do
    long_query = "a" * 256
    results = Task.search_by_title(long_query)
    assert_equal 0, results.count
  end

  # Test helper methods
  test "status_badge_class should return correct class for pending" do
    task = tasks(:one)
    assert_equal "bg-warning text-dark", task.status_badge_class
  end

  test "status_badge_class should return correct class for in_progress" do
    task = tasks(:two)
    assert_equal "bg-info", task.status_badge_class
  end

  test "status_badge_class should return correct class for completed" do
    task = tasks(:three)
    assert_equal "bg-success", task.status_badge_class
  end

  test "status_badge_class should return default class for nil status" do
    task = Task.new(title: "Test")
    task.status = nil
    # Bypass enum validation for this test
    task.send(:write_attribute, :status, nil)
    assert_equal "bg-secondary", task.status_badge_class
  end

  test "status_label should return correct label for pending" do
    task = tasks(:one)
    assert_equal "Pending", task.status_label
  end

  test "status_label should return correct label for in_progress" do
    task = tasks(:two)
    assert_equal "In Progress", task.status_label
  end

  test "status_label should return correct label for completed" do
    task = tasks(:three)
    assert_equal "Completed", task.status_label
  end

  test "status_label should return status for nil status" do
    task = Task.new(title: "Test")
    task.status = nil
    # Bypass enum validation for this test
    task.send(:write_attribute, :status, nil)
    assert_nil task.status_label
  end
end

