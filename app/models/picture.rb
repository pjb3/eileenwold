class Picture
  include Attribution

  belongs_to :gallery

  integer :id
  string :name
  string :title
  integer :year
  string :size
  string :medium
  string :info
  boolean :default

  def image_path(size)
    "/images/galleries/#{gallery.name}/#{size}/#{name}"
  end

  def caption
    "#{title}, #{year}<br />#{medium}, #{size}".html_safe
  end
end
