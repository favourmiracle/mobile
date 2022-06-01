class LaunchLinks

  # Enables dodgeball stream
  def self.launch_stream
    locale = %w[en_GB en_AU nl_BE]

    unless locale.include? ENV['LOCALE'].to_s
      execute_script('mobile: deepLink', {
                                'package' => 'com.solaireresort.mysolairemobileapp.view.activity.SplashActivity'})
    end
  end
end