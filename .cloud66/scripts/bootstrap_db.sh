bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec rake apartment:migrate
bundle exec rake apartment:seed

bundle exec rake environment tire:import CLASS='Asset' FORCE=true