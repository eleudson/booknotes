require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors, :publications

  test "should require name" do
    author = create(:name => nil)
    my_assert_invalid_on(author, :name)
  end

  test "should deny create duplicate author" do
    author = create
    my_assert_valid author

    author = create
    my_assert_invalid author, "Don't should to create duplicate editor"
  end

  test "should_check_publications_authorship" do
    # check all fixtures were loaded
    assert_equal 2, publications(:pateta_gibi).authors.size, "publication should have had 2 authors"
   
    # assign a author using the relationship method
    author = create
    publications(:pateta_gibi).authors << author
    
    #now, check if user have one more post
    assert_equal 3, publications(:pateta_gibi).authors.size, "publication should have had 3 authors"
  end

  # testing user's references
  test "should deny non integer user" do
    author = create(:user_id => 'a')
    assert author.errors.invalid?(:user_id), ":user_id should have had an error"
    my_assert_invalid author, "Author shouldn't be created"
    
    author = create(:user_id => 1.397)
    assert author.errors.invalid?(:user_id), ":user_id should have had an error"
    my_assert_invalid author, "Author shouldn't be created"
  end

  test "should belongs to user" do
    author = create(:name => "Author", :last_name => "Inexist", :user_id => 100)
    my_assert_associated author, "user"
  end

  private

  def create(options={})
    Author.create({
      :name => "Flash",
      :last_name => "Gordon",
      :user_id   => users(:quentin).id 
    }.merge(options))
  end

end
