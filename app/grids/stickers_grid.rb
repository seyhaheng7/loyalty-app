class StickersGrid

  include Datagrid

  scope do
    Sticker
  end

  filter(:name, :string)

  column(:id)
  column(:name)
  column(:image, html: true) do |sticker|
    image_tag sticker.image, size: '150x150'
  end

  column(:actions, html:true) do |record|
    render 'stickers/control', sticker: record
  end

end
