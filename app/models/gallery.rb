class Gallery
  include Attribution

  has_many :pictures

  integer :id
  string :name

  GALLERIES = %w[energy_studies empty_waters west_virginia squaremeter smokestacks transfers photography digitalcrops]

  def self.all
    @galleries ||= GALLERIES.map.with_index do |name, i|
      new(id: i+1,
          name: name,
          pictures: YAML.load_file(Rails.root.join("db/galleries/#{name}.yml")))
    end
  end

  def self.find(id)
    find_by(id: id)
  end

  def self.find_by(params)
    all.detect do |gallery|
      params.all? do |attr, value|
        gallery.send(attr) == value
      end
    end
  end

  def default_picture
    @default_picture ||= pictures.detect(&:default)
  end

  def title
    case name
    when 'digitalcrops' then 'Blocked Out'
    when 'photography' then 'Fueling Baltimore'
    when 'transfers' then 'Energy Infrastructure'
    when 'west_virginia' then 'West Virginia Coal'
    when 'squaremeter' then 'Square Meter'
    else name.titleize
    end
  end

  def to_param
    name
  end

  def description
    case name
    when "energy_studies" then %{How is electricity made, distributed and used? These explorations of renewable energy sources are often constructed out of recycled or found materials.  They reflect limitations of current energy practices as well as the possibility of inquisitive and inventive thought.}
    when "empty_waters" then %{Baltimore's health department warns swimming in the harbor should be avoided due to the risk of disease from bacteria. This project examines our human perception of and relationship to nature, specifically the Chesapeake Bay. As the world’s third largest estuary, the bay was once a pristine place, productive ecosystem and a leading source of U.S. food production. But after years of pollution, what was once known as the great shellfish bay has lost 70 percent of its crabs and almost 100 percent of its oysters. Formerly a thriving body of water is being sacrificed, because of our demand for cheap energy and cheap chicken.}
    when "west_virginia" then %{This project is a documentation of a six month investigation into where the supply at the Baltimore coal terminal comes from. I traveled down to the southern mountain ranges of West Virginia and documented the surface coal mines from the air and the ground. I wanted to investigate the extraction of coal from all angles through drawing, photography, video, interviews with coal miners, as well as environmentalists. I chartered a flight over active and reclaimed mines but also walked along the smallest streams that are changing because of the coal industry. Exploring this topic in both a macro an micro way, the drawings are done from specific areas of photographs to abstract our perception one step further and to see photography as a non-static art experience, to be viewed and reviewed for different information over time.}
    when "squaremeter" then %{This series notates each planetary square meter of mature, 100 year old forest that acts as the carbon sink for each gallon of oil burned. The square meter also frames the rate of deforestation that counteracts that balance. This photographic documentation of performance of placing a square meter of yellow tape in various locations, explores ideas of sustainability but also acts as a reminder of the totality of the political and social systems already in place.}
    else %{}
    end
  end
end
