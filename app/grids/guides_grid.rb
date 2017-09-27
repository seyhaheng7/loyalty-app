class GuidesGrid

  include Datagrid

  scope do
    Guide
  end

  filter(:title, :string)

  column(:title)
  column(:youtube_url)
  # column(:created_at) do |model|
  #   model.created_at.to_date
  # end

  column(:actions, html:true) do |record|
    render 'guides/control', guide: record
  end
end
