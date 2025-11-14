require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  # E2E: View tasks list
  test "visiting the index" do
    visit tasks_url
    
    assert_selector "h1", text: "Tasks"
    assert_selector "table"
    assert_text @task.title
  end

  # E2E: Create new task
  test "creating a Task" do
    visit tasks_url
    click_on "New Task", match: :first

    fill_in "Title", with: "E2E Test Task"
    fill_in "Description", with: "This is a test task created via E2E test"
    select "In Progress", from: "Status"
    click_on "Create Task"

    assert_text "Task was successfully created"
    assert_text "E2E Test Task"
    assert_text "This is a test task created via E2E test"
  end

  test "creating a task with only required fields" do
    visit new_task_url
    
    fill_in "Title", with: "Minimal Task"
    click_on "Create Task"

    assert_text "Task was successfully created"
    assert_text "Minimal Task"
  end

  test "should show validation errors when creating invalid task" do
    visit new_task_url
    
    click_on "Create Task"

    assert_text "error"
    assert_text "prohibited this task from being saved"
  end

  # E2E: View task details
  test "viewing a Task" do
    visit task_url(@task)

    assert_text @task.title
    assert_text @task.description if @task.description.present?
    assert_text @task.status_label
  end

  # E2E: Update task
  test "updating a Task" do
    visit tasks_url
    click_on "Edit", match: :first

    fill_in "Title", with: "Updated Task Title"
    fill_in "Description", with: "Updated description"
    select "Completed", from: "Status"
    click_on "Update Task"

    assert_text "Task was successfully updated"
    assert_text "Updated Task Title"
    assert_text "Updated description"
  end

  test "should show validation errors when updating with invalid data" do
    visit edit_task_url(@task)
    
    fill_in "Title", with: ""
    click_on "Update Task"

    assert_text "error"
    assert_text "prohibited this task from being saved"
  end

  # E2E: Delete task
  # Note: rack_test driver doesn't support JavaScript confirm dialogs
  # So we test the delete action directly (confirmation is handled by Turbo in browser)
  test "destroying a Task" do
    task_to_delete = Task.create!(title: "Task to Delete", status: "pending")
    initial_count = Task.count
    
    visit task_url(task_to_delete)
    # Use button_to which submits directly (no JS needed for rack_test)
    click_on "Delete Task"

    assert_text "Task was successfully deleted"
    assert_equal initial_count, Task.count
  end

  # E2E: Search functionality
  test "searching for tasks" do
    visit tasks_url
    
    fill_in "search", with: "Searchable"
    click_on "Search"

    assert_text "task"
    assert_text "found"
    assert_text "Searchable"
  end

  test "searching with no results" do
    visit tasks_url
    
    fill_in "search", with: "NonexistentTask12345"
    click_on "Search"

    assert_text "No tasks found"
  end

  test "clearing search results" do
    visit tasks_url
    
    fill_in "search", with: "Searchable"
    click_on "Search"
    
    # Verify search results are shown
    assert_text "task"
    assert_text "found"
    assert_text "Searchable"
    
    click_on "Clear"

    assert_current_path tasks_path
    # After clearing, all tasks should be visible again
    assert_selector "table tbody tr", minimum: Task.count
  end

  test "search should be case insensitive" do
    visit tasks_url
    
    fill_in "search", with: "searchable"
    click_on "Search"

    assert_text "task"
    assert_text "found"
  end

  # E2E: Navigation
  test "navigating between pages" do
    visit tasks_url
    click_on "New Task", match: :first
    assert_current_path new_task_path

    click_on "Back to Tasks"
    assert_current_path tasks_path

    # Navigate to a specific task
    visit task_url(@task)
    assert_current_path task_path(@task)
    assert_text @task.title

    click_on "Back to Tasks"
    assert_current_path tasks_path
  end

  # E2E: Task with empty description
  test "viewing task with empty description" do
    empty_task = tasks(:empty_description)
    visit task_url(empty_task)

    assert_text empty_task.title
    assert_text "No description"
  end

  # E2E: Status badges display correctly
  test "status badges display correctly in list" do
    visit tasks_url

    # Check that status badges are present
    assert_selector ".badge", minimum: Task.count
  end

  test "status badges display correctly on show page" do
    visit task_url(@task)
    
    assert_selector ".badge"
    assert_text @task.status_label
  end
end

