class LandMarksGrid

  include Datagrid

  scope do
    LandMark
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }


  column(:name)
  column(:today) do |record|
    record.customer_land_marks.today.count
  end


  column(:actions, html:true) do |record|
    render 'land_marks/control', land_mark: record
  end
end
