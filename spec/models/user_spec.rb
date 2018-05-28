require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:blog_posts) }

  it { should have_db_index(:id) }

  pending "add some examples to (or delete) #{__FILE__}"
end
