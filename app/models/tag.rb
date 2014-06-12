class Tag < ActiveRecord::Base

  has_many :taggers, dependent: :destroy
  has_many :projects, through: :taggers

  validates :name, presence: true, uniqueness: true

end
