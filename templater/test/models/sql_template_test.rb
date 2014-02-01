require 'test_helper'

class SqlTemplateTest < ActiveSupport::TestCase
  test "resolver returns a template with the saved body" do
    resolver = SqlTemplate::Resolver.instance
    details = { formats: [:html], locale: [:en], handlers: [:erb] }

    # Assert resolver cannot find any template as the database is empty
    assert resolver.find_all("index", "posts", false, details).empty?

    SqlTemplate.create!(
      body: "<%= 'Hi from SqlTemplate!' %>",
      path: "posts/index",
      format: "html",
      locale: "en",
      handler: "erb",
      partial: false
    )

    template = resolver.find_all("index", "posts", false, details).first
    assert_kind_of ActionView::Template, template

    assert_equal "<%= 'Hi from SqlTemplate!' %>", template.source
    assert_kind_of ActionView::Template::Handlers::ERB, template.handler
    assert_equal [:html], template.formats
    assert_equal "posts/index", template.virtual_path
    assert_match %r[SqlTemplate - \d+ - "posts/index"], template.identifier
  end

  test "sql_template expires the cache on update" do
    cache_key = Object.new
    resolver = SqlTemplate::Resolver.instance
    details = { formats: [:html], locale: [:en], handlers: [:erb] }

    template = resolver.find_all("index", "users", false, details, cache_key).first
    assert_match "Listing users", template.source

    sql_template = sql_templates(:users_index)
    sql_template.update_attributes(body: "New body for template")

    template = resolver.find_all("index", "users", false, details, cache_key).first
    assert_equal "New body for template", template.source
  end
end
