module Primary
  def is_primary options={}
    cattr_accessor :primary_is_primary_opts
    self.primary_is_primary_opts = options.reverse_merge({
      :on     => :is_primary,
      :scope  => nil
    })

    before_save :primary_is_primary_mark
    after_save :primary_is_primary_take_care
    include InstanceMethods
  end
  module InstanceMethods
    private
      def primary_is_primary_mark
        options = self.class.primary_is_primary_opts
        check = get_primary_scope(options)
        if check.count == 0
          self.send("#{options[:on]}=", true)
        end
      end
      def primary_is_primary_take_care
        options = self.class.primary_is_primary_opts
        if self.send("#{options[:on]}?")==true
          scope = get_primary_scope(options)
          scope = scope.where('id!=?', self.id)
          scope.update_all(["#{options[:on]}=?", false])
        end
      end

      def get_primary_scope(options)
        check = self.class.where("#{options[:on].to_s} = ?", true)
        if options[:scope]
          check = check.where("#{options[:scope].to_s} = ?", self.send(options[:scope]))
        end
        check
      end
  end
end
ActiveRecord::Base.extend Primary
