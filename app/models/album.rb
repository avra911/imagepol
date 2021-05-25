class Album
  include Mongoid::Document
  include Mongoid::Slug

  belongs_to :user
  belongs_to :domain, optional: true
  has_many :photos, dependent: :destroy

  field :domain_id, type: BSON::ObjectId
  field :name, type: String
  slug :name

  field :suffix, type: String
  field :password, type: String
  field :fb_comments, type: Mongoid::Boolean
  field :fb_id, type: String
  field :user_id, type: BSON::ObjectId

  validates_presence_of :name, :suffix
end
