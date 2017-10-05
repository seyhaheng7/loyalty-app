class StickerGroupsGrid

  include Datagrid

  scope do
    StickerGroup
  end

  filter(:name, :string)

  column(:id)
  column(:name)
  column(:image, html: true) do |sticker_group|
    image_tag sticker_group.image, size: '50x50'
  end

  column(:actions, html:true) do |record|
    render 'sticker_groups/control', sticker_group: record
  end

end
