class User < ApplicationRecord
  # Associação: um usuário possui várias listas; ao excluir o usuário, as listas são removidas
  has_many :lists, dependent: :destroy
  # Itens do usuário (através das listas), para consultas no ItemsController
  has_many :items, through: :lists

  # Validações personalizadas de senha (além do :validatable do Devise)
  validate :password_complexity

  # Módulos padrão do Devise. Outros disponíveis:
  # :confirmable, :lockable, :timeoutable, :trackable e :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  # Verifica requisitos de complexidade da senha: maiúscula e caractere especial.
  # O tamanho mínimo (8 caracteres) é validado pelo Devise via config.password_length.
  def password_complexity
    return if password.blank?

    # Pelo menos uma letra maiúscula (A-Z)
    unless password.match?(/[A-Z]/)
      errors.add(:password, "deve conter pelo menos uma letra maiúscula")
    end

    # Pelo menos um caractere especial (! @ # $ % ^ & * etc.)
    unless password.match?(/[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/;'`~]/)
      errors.add(:password, "deve conter pelo menos um caractere especial (! @ # $ % ^ & * etc.)")
    end
  end
end
