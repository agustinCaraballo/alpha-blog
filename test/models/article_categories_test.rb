require 'test_helper'
class ArticleCategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "sports")
    @category2 = Category.new(name: "cooking")
    @article = Article.new(title:"First article",description:"First article as well.")
    @article2 = Article.new(title:"Second article",description:"First article as well.")
  end
  test "article can have multiple categories " do
    @article.categories << @category
    @article.categories << @category2
    @article.valid?
  end
end
