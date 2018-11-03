require 'active_model'

class FakeModel

  extend(ActiveModel::Callbacks)

  define_model_callbacks :update, :create, :destroy

  def update
    run_callbacks(:update) do
      puts 'updated'
    end
  end

  def destroy
    run_callbacks(:destroy) do
      puts 'destroyed'
    end
  end

  def create
    run_callbacks(:create) do
      puts 'create'
    end
  end

end
