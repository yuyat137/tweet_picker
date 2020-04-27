module Enum
  extend ActiveSupport::Concern

  module ClassMethods
    def enum(definitions)
      raise ArgumentError, 'enum attribute_name: { key: value, key: value, ...} の形式で指定してください' unless valid?(definitions)

      attribute = definitions.keys.first
      values = definitions.values.first

      # define_methodはインスタンスメソッドを作成するメソッド。
      # TweetsFormにenumを定義(厳密にはenumメソッドを使用)したら、define_methodで定義したメソッドが使用できるようになる

      # getterを上書き keyの取得
      # attributesはTweetsFormのインスタンスメソッド
      define_method(attribute.to_s) do
        values.invert[attributes[attribute.to_s]]
      end

      # valueの取得
      define_method(attribute.to_s + '_value') do
        attributes[attribute.to_s]
      end

      # 既存のsetterを別名に退避
      alias_method "#{attribute}_value=", "#{attribute}="

      # setterを上書き
      define_method("#{attribute}=") do |argument|
        checked_argument = case argument
                           when Integer
                             values.values.include?(argument) ? argument : nil
                           when String
                             values[argument.to_sym]
                           when Symbol
                             values[argument]
                           else
                             raise ArgumentError, 'string, symbol, integerのいずれかを指定してください'
                           end
        raise ArgumentError, "'#{argument}' is not a valid #{attribute}" if checked_argument.nil?

        send("#{attribute}_value=", checked_argument)
      end

      # enum_helpの_i18n的なメソッド追加
      define_method("#{attribute}_i18n") do
        enumed_value = send(attribute)
        I18n.t("enums.#{self.class.name.underscore}.#{attribute}.#{enumed_value}", default: enumed_value.to_s)
      end

      # enum値一覧を確認できるクラスメソッドを定義
      singleton_class.send(:define_method, attribute.to_s + 's', -> { values })

      # i18n対応のenum値一覧を確認できるクラスメソッドを定義
      singleton_class.send(:define_method, attribute.to_s + 's_i18n', -> { attributes_i18n(attribute, values) })
    end

    private

    def valid?(definitions)
      return false unless definitions.is_a?(Hash)
      return false if definitions.keys.size != 1

      values = definitions.values.first
      return false unless values.is_a?(Hash)
      return false unless values.keys.all? { |key| key.is_a?(Symbol) }
      return false unless values.values.all? { |value| value.is_a?(Integer) }

      true
    end

    def attributes_i18n(attribute, values)
      attributes_i18n = {}
      values.each do |key, _|
        attributes_i18n[key] = I18n.t("enums.tweets_form.#{attribute}.#{key}")
      end
      attributes_i18n
    end
  end
end
