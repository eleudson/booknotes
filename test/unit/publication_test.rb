require 'test_helper'

class PublicationTest < ActiveSupport::TestCase
 fixtures :publications, :editors, :users

  # Replace this with your real tests.
  
  # requireds fields
  test "should require title" do
    publication = create(:title => nil)
    my_assert_invalid_on publication, :title
  end

  test "should require media" do
    publication = create(:media => nil)
    my_assert_invalid_on publication, :media
  end

  test "should require idiom" do
    publication = create(:idiom => nil)
    my_assert_invalid_on publication, :idiom
  end

  test "should require license" do
    publication = create(:license => nil)
    my_assert_invalid_on publication, :license
  end
 
  # find duplicated register
  test "should deny create duplicate publication" do
    publication = create
    my_assert_valid publication

    publication = create
    my_assert_invalid publication, "Don't should to create duplicate editor"
  end

  # testing editor's references
  test "should deny non integer editor" do
    publication = create(:editor_id => 'a')
    assert publication.errors.invalid?(:editor_id), ":editor_id should have had an error"
    my_assert_invalid publication, "Publication shouldn't be created"
    
    publication = create(:editor_id => 1.397)
    assert publication.errors.invalid?(:editor_id), ":editor_id should have had an error"
    my_assert_invalid publication, "Publication shouldn't be created"
  end

  test "should belongs to editor" do
    publication = create(:title => "Livro Absurdo Qualquer", :editor_id => 100)
    my_assert_associated publication, "editor"
  end

  test "should_media_in_the_defined_list" do
    medias = []
    Publication::MEDIAS.each {|k,v| medias << v}

    # exist
    publication = create
    my_assert_inclusion_of(medias, publication.media)

    # don't exist
    publication = create(:media => "XXX")
    my_assert_not_inclusion_of(medias, publication.media)
  end
 
  # testing user's references
  test "should deny non integer user" do
    publication = create(:user_id => 'a')
    assert publication.errors.invalid?(:user_id), ":user_id should have had an error"
    my_assert_invalid publication, "Publication shouldn't be created"
    
    publication = create(:user_id => 1.397)
    assert publication.errors.invalid?(:user_id), ":user_id should have had an error"
    my_assert_invalid publication, "Publication shouldn't be created"
  end

  test "should belongs to user" do
    publication = create(:title => "Livro Absurdo Qualquer", :user_id => 100)
    my_assert_associated publication, "user"
  end

  private

  def create(options={})
    Publication.create({
      :title     => "The space of the earth",
      :editor_id => editors(:manga).id,
      :isbn      => "00000-XYZ",
      :source    => "www.myspacesource.com",
      :media     => "BOOK",      
      :idiom     => "English",
      :license   => "BSDL",
      :user_id   => users(:quentin).id 
    }.merge(options))
  end
  
end

