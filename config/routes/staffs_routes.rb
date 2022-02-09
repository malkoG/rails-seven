module StaffsRoutes
  def self.extended(router)
    router.instance_exec do
      def staffs_resources(resources_symbol, **options, &block)
        if block_given?
          resources resources_symbol, as: "staffs_#{resources_symbol}".to_sym, **options do
            yield
          end
        else
          resources resources_symbol, as: "staffs_#{resources_symbol}".to_sym, **options
        end
      end

      get "welcome" => "staffs/welcome#index"
      get "" => "staffs/welcome#index"
      get "index" => "staffs/welcome#index"

      scope module: "staffs" do
        staffs_resources :petitions
        # 알파벳 순서로 정리
        staffs_resources :admin_users
        staffs_resources :petitions

        get 'welcome/index'
      end
    end
  end
end
