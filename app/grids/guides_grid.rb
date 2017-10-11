class GuidesGrid

  include Datagrid

  scope do
    Guide
  end

  filter(:title, :string)

  #add 's' to thumbnail cuz it duplicate with bootstrap class
  column(:thumbnails, html: true) do |record|
    image_tag record.thumbnail, size: '50x50'
  end

  column(:title)
  column(:youtube_url)
  

  column(:actions, html:true) do |record|
    render 'guides/control', guide: record
  end
end
