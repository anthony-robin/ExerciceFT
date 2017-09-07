# Categories Creatable
#
RSpec.shared_examples_for :category_creatable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to admin_categories_url }

  it 'creates a record' do
    expect { create_category }.to change(Category, :count).by(1)
  end

  describe 'flash message' do
    before { create_category }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('admin.categories.create.notice')
    end
  end
end

# Categories Updatable
#
RSpec.shared_examples_for :category_updatable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to admin_categories_url }

  describe 'flash message' do
    before { update_category }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('admin.categories.update.notice')
    end
  end

  describe 'values' do
    before { update_category }

    it 'changes name' do
      expect(assigns(:category).name).to eq 'FooBar update'
    end
  end
end

# Categories Destroyable
#
RSpec.shared_examples_for :category_destroyable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to admin_categories_url }

  describe 'flash message' do
    before { destroy_category }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('admin.categories.destroy.notice')
    end
  end

  it 'destroys a category' do
    expect { destroy_category }.to change(Category, :count).by(-1)
  end

  it 'destroys associated blogs' do
    expect { destroy_category }.to change(category.blogs, :count).by(-3)
  end
end
