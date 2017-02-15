class Company
  include ActiveModel::Model

  attr_accessor(
    :name,
    :website,
    :logo_url,
    :address,
    :hiring_url,
    :email,
    :contribution_count
  )

  validates_presence_of(
    :name,
    :website,
    :logo_url,
    :address,
    :email
  )

  def supporter?
    contribution_count.to_i > 1
  end

  def self.all
    RubysgReboot::COMPANIES.map { |company| Company.new(company) }.sort_by { |company| company.name.downcase }
  end
end
