require 'spec_helper'
require 'rails_helper'

RSpec.describe BlogPost, type: :model do

  it { should have_many(:ratings) }
  it { should have_db_index(:middle_rating) }
  it { should have_db_index(:user_id) }
  it { should have_db_index([:author_ip, :user_id]) }

  pending "add some examples to (or delete) #{__FILE__}"
end
