class PlantsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Plant.count,
      iTotalDisplayRecords: plants.total_entries,
      aaData: data
    }
  end

private

  def data
    plants.map do |plant|
      [
        link_to(plant.plant_symbol, plant),
        h(plant.syn_symbol),
        h(plant.sci_name),
        h(plant.common_name),
        h(plant.plant_family)
      ]
    end
  end

  def plants 
    @plants ||= fetch_plants
  end

  def fetch_plants
    plants = Plant.order("#{sort_column} #{sort_direction}")
    plants = plants.page(page).per_page(per_page)
    if params[:sSearch].present?
      plants = plants.where("plant_symbol like :search 
        or sci_name like :search
        or common_name like :search
        or plant_family like :search", search: "%#{params[:sSearch]}%")
    end
   plants 
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[plant_symbol syn_symbol sci_name common_name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end