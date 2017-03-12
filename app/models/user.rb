class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  has_many :places, dependent: :destroy
  has_many :reviews, dependent: :destroy


  # only allowed JSON returned value for name and email for user.
  def as_json(options={})
  	super(only: [:name, :email])
  end

end
