module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when 'success'
        "alert-success"
      when 'error'
        "alert-error"
      when 'alert'
        "alert-block"
      when 'notice'
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def sidebar_active?(controller)
    controller_name == controller
  end

  def path_for_notification(notification)
    type = notification.notification_type
    object = notification.objectable_id

    case type

    when 'SubmittedReceipt'
      receipt_path(object)
    when 'ClaimedRewardSuccess'
      claimed_reward_path(object)
    else
      raise "Unknown type"
    end

  end


end
