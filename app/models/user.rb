class User < ApplicationRecord
  # Associação: um usuário possui várias listas; ao excluir o usuário, as listas são removidas
  has_many :lists, dependent: :destroy
  # Itens do usuário (através das listas), para consultas no ItemsController
  has_many :items, through: :lists

  # Módulos padrão do Devise. Outros disponíveis:
  # :confirmable, :lockable, :timeoutable, :trackable e :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
