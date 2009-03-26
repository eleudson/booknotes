require 'test_helper'

class EditorTest < ActiveSupport::TestCase
  fixtures :editors

  # Replace this with your real tests.
  test "should require name" do
    editor = create(:name => nil)
    my_assert_invalid_on(editor, :name)
  end

  test "should deny create duplicate editor" do
    editor = create
    my_assert_valid editor

    editor = create
    my_assert_invalid editor, "Don't should to create duplicate editor"
  end

  # testing user's references
  test "should deny non integer user" do
    editor = create(:user_id => 'a')
    assert editor.errors.invalid?(:user_id), ":user_id should have had an error"
    my_assert_invalid editor, "Editor shouldn't be created"
    
    editor = create(:user_id => 1.397)
    assert editor.errors.invalid?(:user_id), ":user_id should have had an error"
    my_assert_invalid editor, "Editor shouldn't be created"
  end

  test "should belongs to user" do
    editor = create(:name => "Editor Inexist", :user_id => 100)
    my_assert_associated editor, "user"
  end

  private

  def create(options={})
    Editor.create({
      :name => "Paulo Coelho Press",
      :user_id   => users(:quentin).id 
    }.merge(options))
  end
end 
