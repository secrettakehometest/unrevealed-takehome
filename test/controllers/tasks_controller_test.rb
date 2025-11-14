require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  # Test index action
  test "should get index" do
    get tasks_url
    assert_response :success
    assert_select "h1", "Tasks"
  end

  test "index should display all tasks" do
    get tasks_url
    assert_response :success
    assert_select "table tbody tr", minimum: Task.count
  end

  test "index should filter by search query" do
    get tasks_url, params: { search: "Searchable" }
    assert_response :success
    assert_select "table tbody tr", minimum: 1
  end

  test "index should show search results count" do
    get tasks_url, params: { search: "Searchable" }
    assert_response :success
    assert_match(/task.*found/, response.body)
  end

  test "index should show no results message when search returns empty" do
    get tasks_url, params: { search: "NonexistentTask12345" }
    assert_response :success
    assert_match(/No tasks found/, response.body)
  end

  # Test show action
  test "should get show" do
    get task_url(@task)
    assert_response :success
    assert_match(@task.title, response.body)
  end

  test "should show task details" do
    get task_url(@task)
    assert_response :success
    assert_match(@task.title, response.body)
    assert_match(@task.description, response.body) if @task.description.present?
  end

  test "should redirect to tasks when task not found" do
    get task_url(id: 99999)
    assert_redirected_to tasks_path
    assert_equal "Task not found.", flash[:alert]
  end

  # Test new action
  test "should get new" do
    get new_task_url
    assert_response :success
    assert_select "h1", "New Task"
  end

  test "new should render form" do
    get new_task_url
    assert_response :success
    assert_select "form"
    assert_select "input[name='task[title]']"
    assert_select "textarea[name='task[description]']"
    assert_select "select[name='task[status]']"
  end

  # Test create action
  test "should create task with valid parameters" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { title: "New Task", description: "Description", status: "pending" } }
    end

    assert_redirected_to task_path(Task.last)
    assert_equal "Task was successfully created.", flash[:notice]
  end

  test "should not create task without title" do
    assert_no_difference("Task.count") do
      post tasks_url, params: { task: { description: "Description", status: "pending" } }
    end

    assert_response :unprocessable_entity
  end

  test "should create task with default status when not provided" do
    post tasks_url, params: { task: { title: "New Task", description: "Description" } }
    task = Task.last
    assert_equal "pending", task.status
  end

  test "should create task with all status values" do
    %w[pending in_progress completed].each do |status|
      post tasks_url, params: { task: { title: "Task #{status}", status: status } }
      assert_equal status, Task.last.status
    end
  end

  # Test edit action
  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
    assert_select "h1", "Edit Task"
  end

  test "edit should render form with task data" do
    get edit_task_url(@task)
    assert_response :success
    assert_select "form"
    assert_select "input[name='task[title]'][value='#{@task.title}']"
  end

  test "should redirect to tasks when editing non-existent task" do
    get edit_task_url(id: 99999)
    assert_redirected_to tasks_path
    assert_equal "Task not found.", flash[:alert]
  end

  # Test update action
  test "should update task with valid parameters" do
    patch task_url(@task), params: { task: { title: "Updated Title", description: "Updated Description", status: "completed" } }
    
    @task.reload
    assert_equal "Updated Title", @task.title
    assert_equal "Updated Description", @task.description
    assert_equal "completed", @task.status
    assert_redirected_to task_path(@task)
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  test "should not update task with invalid parameters" do
    patch task_url(@task), params: { task: { title: "" } }
    
    assert_response :unprocessable_entity
    @task.reload
    assert_not_equal "", @task.title
  end

  test "should redirect to tasks when updating non-existent task" do
    patch task_url(id: 99999), params: { task: { title: "Updated" } }
    assert_redirected_to tasks_path
    assert_equal "Task not found.", flash[:alert]
  end

  # Test destroy action
  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
    assert_equal "Task was successfully deleted.", flash[:notice]
  end

  test "should redirect to tasks when destroying non-existent task" do
    delete task_url(id: 99999)
    assert_redirected_to tasks_path
    assert_equal "Task not found.", flash[:alert]
  end

  # Test search functionality
  test "should search case insensitively" do
    get tasks_url, params: { search: "searchable" }
    assert_response :success
    assert_select "table tbody tr", minimum: 1
  end

  test "should search with partial matches" do
    get tasks_url, params: { search: "Search" }
    assert_response :success
    assert_select "table tbody tr", minimum: 1
  end

  test "should maintain search query in view" do
    get tasks_url, params: { search: "Searchable" }
    assert_response :success
    assert_match(/Searchable/, response.body)
  end
end

