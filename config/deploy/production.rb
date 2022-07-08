set :stage, :production
set :branch, "2020_annual_review"


server "web-supported-production.linode.unep-wcmc.org", user: 'wcmc', roles: %w{app web db}

set :application, "2020_annual_review"
set :server_name, "2020_annual_review.web-supoorted-production.linode.unep-wcmc.org"
set :sudo_user, "wcmc"
set :app_port, "80"



#set :yarn_target_path, -> { release_path.join('client') } #
#set :yarn_flags, '--silent --no-progress'    # default
#set :yarn_roles, :all                                     # default
#set :yarn_env_variables, {}
