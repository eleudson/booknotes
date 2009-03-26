require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :publications, :notes

  test "should require name" do
    note = create(:name => nil)
    my_assert_invalid_on note, :name
  end
 
  test "should be initial page a positive integer" do
    note = create(:init_page => nil)
    my_assert_invalid_on note, :init_page
    
    note = create(:init_page => 'a')
    my_assert_invalid_on note, :init_page

    note = create(:init_page => -1)
    my_assert_invalid_on note, :init_page
  end

  test "should be last page a positive integer greater than or equal the initial page" do
    note = create(:last_page => nil)
    my_assert_invalid_on note, :init_page
    
    note = create(:last_page => 'a')
    my_assert_invalid_on note, :last_page

    note = create(:last_page => -1)
    my_assert_invalid_on note, :init_page

    note = create(:init_page => 15, :last_page => 10)
    my_assert_invalid note, :init_page
  end

  test "should require body" do
    note = create(:body => nil)
    my_assert_invalid note, :body 
  end

  test "should belongs to publication" do
    note = create(:publication_id => 100)
    my_assert_associated note, "publication"
  end

  private

  def create(options={})
    Note.create({
      :publication_id => publications(:naruto_manga).id,
      :name => "Naruto on the montain",
      :init_page => 10,
      :last_page => 12,
      :body => "Naturo to go up the cume of the great montai"
    }.merge(options))
  end
end
