class StaffsIndexGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def generate_file
    template "index.html.erb", "app/views/staffs/#{plural_gen_path}/index.html.erb"
    template "_filter.html.erb", "app/views/staffs/#{plural_gen_path}/_filter.html.erb"
    template "_models.html.erb", "app/views/staffs/#{plural_gen_path}/_#{plural_model_name}.html.erb"
    template "_model.html.erb", "app/views/staffs/#{plural_gen_path}/_#{singular_model_name}.html.erb"
    template "_model_info.html.erb", "app/views/staffs/#{plural_gen_path}/_#{singular_model_name}_info.html.erb"
    template "show.html.erb", "app/views/staffs/#{plural_gen_path}/show.html.erb"
    template "edit.html.erb", "app/views/staffs/#{plural_gen_path}/edit.html.erb"
    template "new.html.erb", "app/views/staffs/#{plural_gen_path}/new.html.erb"
    template "_form.html.erb", "app/views/staffs/#{plural_gen_path}/_form.html.erb"
    template "controller.rb.erb", "app/controllers/staffs/#{plural_model_name}_controller.rb"

    sentinel = /scope module\: \"staffs\" do\n/m
    routing_code = "staffs_resources :#{plural_gen_path}"
    indent = 8
    code = optimize_indentation(routing_code, indent)
    in_root do
      inject_into_file "config/routes/staffs_routes.rb", code, after: sentinel, verbose: false, force: false
    end
    puts "link_to #{plural_gen_path}, staffs_#{plural_gen_path}_path"
    puts "rails g repository #{singular_model_name}"
  end

  private

  def column_names
    names = %I[created_at updated_at id]
    not_model_class = Kernel.const_defined?(singular_model_camel_name) == false
    return names if not_model_class
    constantize_class = singular_model_camel_name.constantize
    columns = constantize_class.attribute_names
  end

  def typed_column(column)
    constantize_class = singular_model_camel_name.constantize
    column_type = constantize_class.columns_hash[column].type
    column_with_model = "#{singular_model_name}.#{column}"
    datetime_column = "l(#{column_with_model}, format: :short)"
    return datetime_column if column_type == :datetime
    column_with_model
  end

  def column_symbols
    column_names.map { |column| ":#{column}" }.join(", ")
  end

  def singular_model_name
    if singular_gen_path.include?("/")
      singular_gen_path.split("/").last
    else
      singular_gen_path
    end
  end

  def singular_model_name_capitalize
    singular_model_name.capitalize
  end

  def plural_model_name
    if plural_gen_path.include?("/")
      plural_gen_path.split("/").last
    else
      plural_gen_path
    end
  end

  def file_path
    if singular_gen_path.include?("/")
      namespace = singular_gen_path.split("/").first
      "#{namespace}_#{plural_model_name}_path"
    else
      "#{plural_model_name}_path"
    end
  end

  def singular_gen_path
    name.downcase.singularize
  end

  def plural_gen_path
    name.downcase.pluralize
  end

  def singular_model_camel_name
    singular_model_name.classify
  end

  def camel_controller_name
    name.classify.pluralize
  end

  def underscore_controller_name
    name.underscore.pluralize
  end

  def underscore_model_name
    underscored = name.underscore.singularize
    if underscored.include?("/")
      underscored.split("/").join("_")
    else
      underscored
    end
  end
end
