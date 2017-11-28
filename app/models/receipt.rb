class Receipt < ApplicationRecord
  include AASM

  aasm :column => 'status' do
    state :submitted, :initial => true
    state :rejected
    state :approved

    event :rejecting, after: [:create_rejected_notifications, :broadcast_receipt_status] do
      transitions :from => :submitted, :to => :rejected
    end

    event :approving, after: [:add_points_to_user, :create_approved_notifications, :broadcast_receipt_status] do
      transitions :from => :submitted, :to => :approved
    end
  end

  acts_as_paranoid

  belongs_to :store
  belongs_to :customer
  belongs_to :managed_by, :class_name => "User", optional: true

  has_many :notifications, as: :objectable, dependent: :destroy
  mount_base64_uploader :capture, ImageUploader

  validates :receipt_id, presence: true
  validates :total, presence: true
  validates :capture, presence: true
  validates :receipt_id, :uniqueness => {:scope => :store_id, message: "Receipt is already submitted"}

  after_create :create_notifications

  delegate :name, to: :store, prefix: true, allow_nil: true
  delegate :name, to: :customer, prefix: true, allow_nil: true

  default_scope { order(created_at: :desc) }

  scope :in_month, ->(date){ where(created_at: (date.beginning_of_month)..(date.end_of_month)) }
  scope :this_month, ->{ in_month(Date.today) }
  scope :last_month, ->{ in_month(Date.today-1.month) }
  scope :before_last_month, ->{ where("#{table_name}.created_at < ? ", Time.now.beginning_of_month - 2.month) }
  scope :in_category, ->(category_id){ joins(:store).merge(Store.in_category(category_id)) }

  def self.time_filter(time)
    records = all
    if time == 'bofore_last_month'
      records = records.before_last_month
    elsif time == 'last_month'
      records = records.last_month
    else
      records = records.this_month
    end
    records
  end


  # {
  #   months: ['Jun 2017', 'July 2017', 'Aug 2017'],
  #   data: [{
  #     name: 'Food',
  #     data: [3000, 4000, 5000]
  #   },{
  #     name: 'Fashion',
  #     data: [5000, 4000, 3000]
  #   }]
  # }
  def self.dashboard_statistic
    today = Date.today
    months = [today-2.month, today-1.month, today ]
    monthsFormatted = months.map{ |date| date.strftime('%b %y') }
    statistic_data = Category.all.map do |category|
      category_data = months.map do |month|
        Receipt.in_month(month).in_category(category.id).sum(:total)
      end

      {
        name: category.name,
        data: category_data
      }
    end

    {
      months: months.map{ |date| date.strftime('%b %y') },
      data: statistic_data
    }
  end


  def new_store=(params)
    new_store = Store.new params
    new_store.completed = false
    new_store.save(validate: false)
    self.store = new_store
  end

  def calculate_earned_points
    self.earned_points = total.to_i / Setting.rating.to_i
  end

  private

  def add_points_to_user
    customer.add_points earned_points.to_i
  end

  def create_notifications
    SubmittedReceiptNotificationsWorker.perform_in(1.seconds, id)
  end

  def create_rejected_notifications
    RejectReceiptNotificationsWorker.perform_async(id)
  end

  def create_approved_notifications
    ApprovedReceiptNotificationsWorker.perform_async(id)
  end

  def broadcast_receipt_status
    ActionCable.server.broadcast "receipt_approval_channel", id: id, status: status
  end

end
