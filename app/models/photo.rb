class Photo
  include Mongoid::Document
  include Mongoid::Paperclip

  belongs_to :album
  belongs_to :user

  Paperclip.interpolates :parent_id do |a, s|
    a.instance.album.id
  end

  rateable range: (0..1), raters: User
  index({ rating: -1 }, { name: "rating_index" })
  index({ rates: -1 }, { name: "rates_index" })

  has_mongoid_attached_file :upload, styles: { standard: '1000x1000', medium: '300x300>', thumb: '100x100>' },
                            # preserve_files: "false",
                            default_url: '/uploads/:style/missing.png'

  validates_attachment 	:upload,
                        presence: true,
                        content_type: { content_type: /\Aimage\/.*\Z/ },
                        size: { less_than: 2.megabyte }

  field :title, type: String
  field :filename, type: String
  field :description, type: String

  attr_accessor :vote
end
