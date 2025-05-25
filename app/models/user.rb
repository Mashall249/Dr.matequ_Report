class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :materials, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :clinical_department, presence: true, uniqueness: true
  validate :proper_clinical_department

  private

  def proper_clinical_department
    unless clinical_department.ends_with('科')
      errors.add(:clinical_department, '最後に「科」をつけてください。')
    end
  end
end
