class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_commit :send_admin_notification, on: :create
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lists
  has_one_attached :photo

  private

  def send_admin_notification
    AdminMailer.new_user_notification(self).deliver_later
  end

end
