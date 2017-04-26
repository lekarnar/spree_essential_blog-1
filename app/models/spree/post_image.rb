class Spree::PostImage < Spree::Asset

  has_attached_file :attachment,
    :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
    :default_style => :medium,
    :url => '/spree/posts/:id/:style/:basename.:extension',
    :path => ':rails_root/public/spree/posts/:id/:style/:basename.:extension'

  validates_attachment_presence :attachment
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def image_content?
    attachment_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end

  def attachment_sizes
    hash = {}
    hash.merge!(:mini => '150x150', :small => '480x480>', :medium => '600x600>', :large => '950x700>') if image_content?
    hash
  end

end
