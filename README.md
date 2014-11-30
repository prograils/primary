#Primary
![travis-ci](https://secure.travis-ci.org/prograils/primary.png)

`primary` is simple gem/plugin that will help you ensure, that you have only one primary / default record in DB. Ie. your site can have multiple languages (stored in db), but only one of them is primary / default. 

## Instalation

Simply add `gem 'primary'` to your `Gemfile`.

After running `bundle install` you can mark model as acting as primary / default.

## Usage

To your model (ie. `Language`) add `is_primary` column and declare models as beeing primary by adding `is_primary` declaration:
```ruby
class Language < ActiveRecord::Base
  is_primary
  
  attr_accessible :language, :is_primary
end
```
###Sample
```ruby
Language.count
# => 0

lang_en = Language.create({:language=>'en'})
lang_en.is_primary
# => true

lang_de = Language.create({:language=>'de'})
lang_de.is_primary
# => false

lang_de.is_primary = true
lang_de.save
lang_de.is_primary
# => true

lang_en.reload
lang_en.is_primary
# => false
```
###Possible options
```ruby
is_primary :on=>'is_default', :scope=>'site_id'

:on     => 'is_default'   # use different column name
:scope  => 'site_id'      # scope default to different column - ie. you'll
                          # be able to define multiple languages per multiple
                          # sites and each site will have one default lang.
                          
                          # Scope can be defined as array of params
:scope => ['site_id', 'language_code']
:scope => ['polymorphic_id', 'polymorphic_type']
```

##Requirements

Currently gem requires Rails 3.2, I'll have to check, if it works as desired with lower versions of Ruby.

##License

Project is distributed under general terms of MIT-LICENSE.
