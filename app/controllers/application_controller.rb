class ApplicationController < ActionController::Base
  before_action :set_user

  def set_user
    # Проверить есть ли у гостя уже идентификатор
    guest_uuid = cookies[:guest_uuid]
    puts "=========== GUEST UUID ==========="
    puts guest_uuid

    # ЕСЛИ ЕСТЬ ТО
    if guest_uuid
      # Найти последнюю активную вопрос этого гостя
      @user = User.where(guest_uuid: guest_uuid).last
      @user ||= User.create!(guest_uuid: guest_uuid)
    # ЕСЛИ НЕТ ТО
    else
      # Тегировать гостевого пользователя (добавить пользователю идентификатор)
      # Создать ему корзину
      uuid = SecureRandom.uuid
      cookies[:guest_uuid] = uuid

      @user = User.create!(guest_uuid: uuid)
    end
  end
end
