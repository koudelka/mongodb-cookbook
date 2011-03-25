class Chef
  class Recipe

		def mongodb_process(name, variables = {})
			include_recipe "logrotate"
      require_recipe "monit::default"

			config = node[:mongodb][name.to_sym]

			if config[:dbpath]
				directory config[:dbpath] do
					owner "mongodb"
					group "mongodb"
					mode 0755
					recursive true
				end
			end

			file config[:logfile] do
				owner "mongodb"
				group "mongodb"
				mode 0644
				action :create_if_missing
				backup false
			end

			config_file_variables = variables[:config] || {}
			config_file_variables[:server_type] = name.to_sym

			template config[:config] do
				source "mongodb.conf.erb"
				owner "mongodb"
				group "mongodb"
				mode 0644
				backup false
				variables config_file_variables
			end

			service_name = "mongodb-#{name}"
			init_variables = variables[:init] || {}
			init_variables[:server_type] = name.to_sym

			if node[:mongodb][:installed_from] == "apt"
				template "/etc/init/#{service_name}.conf" do
					source "mongodb.upstart.erb"
					owner "root"
					group "root"
					mode 0644
					backup false
					variables init_variables
				end

        link "/etc/init.d/#{service_name}" do
          to "/lib/init/upstart-job"
        end
			elsif node[:mongodb][:installed_from] == "src"
				template "/etc/init.d/#{service_name}" do
					source "mongodb.init.erb"
					mode 0755
					backup false
					variables init_variables
				end
			end

			service service_name do
				supports :start => true, :stop => true, "force-stop" => true, :restart => true, "force-reload" => true, :status => true
				action [:enable, :start]

				case node[:platform]
				when "ubuntu"
					if node[:platform_version].to_f >= 9.10
						provider Chef::Provider::Service::Upstart
					end
				end

				subscribes :restart, resources(:template => config[:config])
				subscribes :restart, resources(:template => "/etc/init.d/#{service_name}") if node[:mongodb][:installed_from] == "src"
				subscribes :restart, resources(:template => "/etc/init/#{service_name}.conf") if node[:mongodb][:installed_from] == "apt"
			end

			logrotate "mongodb-#{service_name}" do
				files config[:logfile]
				frequency "daily"
				rotate_count 14
				compress true
				# http://www.mongodb.org/display/DOCS/Logging
				restart_command "kill -SIGUSR1 `cat #{config[:pidfile]}`"
			end

      monitrc('mongodb', :app_name => name, :config => config)

		end

	end
end
