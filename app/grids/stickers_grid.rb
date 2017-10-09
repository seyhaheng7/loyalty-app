class StickersGrid

  include Datagrid

  scope do
    Sticker
  end

  filter(:name, :string)

  column(:name)
  column(:image, html: true) do |sticker|
    image_tag sticker.image, size: '50x50'
  end

  column(:actions, html:true) do |record|
    render 'stickers/control', sticker: record
  end

end
