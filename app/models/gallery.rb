class Gallery
  include Attribution

  has_many :pictures

  integer :id
  string :name

  GALLERIES = %w[smokestacks transfers photography installation digitalcrops squaremeter]

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
    name.titleize
  end

  def to_param
    name
  end
end
