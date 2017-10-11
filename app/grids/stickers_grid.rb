class StickersGrid

  include Datagrid

  scope do
    Sticker.includes(:sticker_group)
  end

  filter(:name, :string)

  column(:name)
  column(:image, html: true) do |sticker|
    image_tag sticker.image, size: '50x50'
  end

  column(:sticker_group_name)

  column(:actions, html:true) do |record|
    render 'stickers/control', sticker: record
  end

end
