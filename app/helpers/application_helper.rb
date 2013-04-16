module ApplicationHelper

  def build_nav
    months = Article.all.collect { |a| a[:created_at].month }.uniq

    markup = '<ul id="monthly">'
    months.each do |m|
      markup += "<li>#{link_to Date::MONTHNAMES[m], articles_path(:type => 'month', :month => m)}</li>"
    end
    markup += "</ul>"

    return markup.html_safe
  end
end
