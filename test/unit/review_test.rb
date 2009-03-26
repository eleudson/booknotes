require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  fixtures :publications, :reviews

  # Replace this with your real tests.
  test "should require body" do
    review = create(:body => nil)
    my_assert_invalid_on review, :body
  end

  test "should belongs to publication" do
    review = create(:publication_id => 100)
    my_assert_associated review, "publication"
  end

  private

  def create(options={})
    Review.create({
      :publication_id => publications(:naruto_manga).id,
      :body => "The brave Naruto Sam and yours endless fights"
    }.merge(options))
  end

end
