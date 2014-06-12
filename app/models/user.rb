class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :project_members, dependent: :destroy
  has_many :member_of_projects, through: :project_members, source: :project

  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project

  def name_display 
    if first_name || last_name
      ["#{first_name}", "#{last_name}"].map(&:capitalize).join(" ").squeeze(" ").strip
    else
      email
    end
  end


end
