module Primary
  def is_primary options={}
    cattr_accessor :primary_is_primary_opts
    self.primary_is_primary_opts = options.reverse_merge({
      :on                  => :is_primary,
      :scope               => nil,
      :auto_primary_record => true
    })

    before_save :primary_is_primary_mark
    after_save :primary_is_primary_take_care
    include InstanceMethods
  end
  module InstanceMethods
    private
      def primary_is_primary_mark
        options = self.class.primary_is_primary_opts
        return unless !!options[:auto_primary_record]

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
        check = self.class.default_scoped.where("#{options[:on].to_s} = ?", true)
        if options[:scope]
          sc = options[:scope]
          if sc.is_a?(Symbol) or sc.is_a?(String)
            check = build_primary_scope(check, sc)
          elsif sc.is_a?(Array)
            sc.each do |scope_elem|
              check = build_primary_scope(check, scope_elem)
            end
          end
        end
        check
      end

      def build_primary_scope(scope_chain, elem)
        if elem.is_a?(String)
          elem = elem.to_sym
        end
        scope_chain.where("#{elem} = ?", self.send(elem))
      end
  end
end
ActiveRecord::Base.extend Primary
