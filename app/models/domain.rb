class Domain
  require "resolv"
  DNS_PREFIX = "imagepol"

  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :user
  has_many :albums, dependent: :destroy

  index({ name: 1 }, { unique: true, name: "name_index" })

  field :name, type: String
  attr_accessor :verified

  def verify!
    verify_domain unless self.verified == true
  end

  validates_format_of :name, with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}?\Z/ix

  protected
  def verify_domain

    Resolv::DNS.open do |domain|
      @dns = domain.getresources("#{DNS_PREFIX}.#{name}", Resolv::DNS::Resource::IN::TXT)
      self.verified = !@dns.empty? && @dns.first.strings.first == self.user_id.to_s
    end
  end
end
