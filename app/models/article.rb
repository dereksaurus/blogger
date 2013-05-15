class Article < ActiveRecord::Base
  attr_accessible :title, :body, :tag_list, :image, :view_count
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image

  scope :by_month, lambda {|month| where('strftime("%m", created_at) = ?', "%02d" % month)}

  def self.most_popular
    all.sort_by{|a| a.view_count}.reverse
  end

  def tag_list
    self.tags.collect do |tag|
      tags.name
    end.join(',')
  end

  def tag_list=(string_tags)
    tag_names = string_tags.split(',').collect {|tag| tag.downcase}.uniq
    new_or_found_tags = tag_names.collect{|name| Tag.find_or_create_by_name name}
    self.tags = new_or_found_tags
  end

  def increment_view
    self.increment :view_count
    self.save
  end
  
end
