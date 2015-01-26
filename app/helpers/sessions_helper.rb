module SessionsHelper
  
  def sign_in(user)
    #создаем токен
    remember_token = User.new_remember_token
    #присваевываем кукам значение токена + устанавливаем время действия куки в 20 лет с помощью .permanent
    cookies.permanent[:remember_token] = remember_token
    #сохраняем значение в базу через update_attribute
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    #устанавливаем текущего пользователя равным данному пользователю
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    #ищем текущего пользователя
    #берем данные токена из куки и шифруем
    remember_token = User.encrypt(cookies[:remember_token])
    #присваеваем значение (усли есть)
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    #Обновляем атрибут куки в базе (на всякий случай)
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    #удаляем куку из браузера
    cookies.delete(:remember_token)
    #юзеру присваеваем значение ниль(пользователь выйде даже без редиректа)
    self.current_user = nil
  end

end
