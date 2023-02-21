# frozen_string_literal: true

class PersonalSite
  hash_routes.on 'about' do |r|
    r.get do
      view('about/index')
    end
  end
end
