require 'spec_helper'
require 'rails_helper'

RSpec.describe Rating, type: :model do

  it { should have_db_index(:blog_post_id) }
  it { should have_db_index(:id) }

  pending "add some examples to (or delete) #{__FILE__}"
end
