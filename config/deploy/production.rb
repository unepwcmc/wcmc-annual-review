set :stage, :production
set :branch, :master


server "web-supported-production.linode.unep-wcmc.org", user: 'wcmc', roles: %w{app web db}

set :application, "2021_annual_review"
set :server_name, "annualreview2021.web-supported-production.linode.unep-wcmc.org"
set :sudo_user, "wcmc"
set :app_port, "80"



#set :yarn_target_path, -> { release_path.join('client') } #
#set :yarn_flags, '--silent --no-progress'    # default
#set :yarn_roles, :all                                     # default
#set :yarn_env_variables, {}
