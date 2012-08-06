# RevRise Ruby API

Tracking events serverside with Ruby and RevRise is as straight forward as a ninjas sword. 

Used for general event tracking, rather than for analyzing forms which [RevRise Form Analytics](http://revrise.com "Analyzing Web Forms") is providing.

## Installation

    gem install revrise
    
or, in your Gemfile:

    gem "revrise", "~> 0.0.3"
    
then
    
    bundle install
    
## Initializing/configuring

Initialize a RevRise::Base object with your project token, then basically call the ´track´ method of that object.

    r = RevRise::Base.new("#{PROJECT_TOKEN}")
    r.track 'event-name', {
      :prop1 => "First",
      :yo_mo => "Second value"
    }
    
For programming specific questions e-mail jonas.arnklint@revrise.com, for more help and documentation regarding Revrise, visit the [Form Analytics](http://revrise.com "RevRise Form Analytics") section.



