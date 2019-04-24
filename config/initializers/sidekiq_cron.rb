schedule_file = 'config/cron_schedule.yml'

if Sidekiq.server?
  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    Rails.logger.info 'Sidekiq Cron was loaded successfully'
  else
    Rails.logger.info "Failed to start Sidekiq Cron. Please check your config/#{schedule_file} file"
  end
end
