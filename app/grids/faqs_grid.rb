class FaqsGrid

  include Datagrid

  scope do
    Faq
  end

  filter(:title, :string){ |value, scope| scope.title_like(value) }

  column(:title)
  column(:actions, html:true) do |record|
    render 'faqs/control', faq: record
  end
end
