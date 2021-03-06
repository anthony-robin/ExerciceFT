require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#website_conf' do
    subject { website_conf }

    it { is_expected.to eq Rails.configuration.website }
    it { is_expected.to include('title') }
  end

  describe '#retina_image_tag' do
    subject { retina_image_tag(picture, :image, :large) }

    let!(:picture) { create(:picture, :for_blog) }

    it { is_expected.to eq '<img srcset="/uploads/picture/1/large_2x_image.jpg 2x" src="/uploads/picture/1/large_image.jpg" alt="Large image" />' }
  end
end
