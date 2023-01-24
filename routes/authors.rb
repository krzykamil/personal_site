# frozen_string_literal: true

class PersonalSite
  hash_routes.on 'authors' do |_r|
    set_view_subdir 'authors'
  end
end
