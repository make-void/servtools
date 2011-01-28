# defaults: { type: :rack }
SITES = {
  defaulter:  
    { domains: %w(qntrol.com), check: "404 - Page not found", catchall: true },
  makevoid:
    { domains: %w(makevoid.com makevoid.net makevoid.it francescocanessa.com), check: "makevoid's blog" },
  pp:
    { domains: %w(pietroporcinai.net pietroporcinai.com pietroporcinai.it), check: "Pietro Porcinai" },    
    



  #vstaging:
    #{ domains: %w(vstaging.makevoid.com), check: "Versus \(staging\)", env: "staging" },

  # pingaholic:
  #   { domains: %w(pingaholic.com) },
  
  cohesionsocial:
    { domains: %w(erasmusquestionnaire.eu), check: "Erasmus Questionnaire" },
  cohesionsocial_staff:
    { domains: %w(staff.erasmusquestionnaire.eu), check: "Erasmus Questionnaire", env: "production_staff" },
    


  #versus:
  #  { domains: %w(new-tv.it versus.new-tv.it versus.makevoid.com), min_instances: 2, check: "Versus" },


  kk:
    #{ domains: %w(kk.makevoid.com), check: "Killers", type: :joomla },
    { domains: %w(kk.makevoid.com), check: "gaming community" },
  kkforum:
    { domains: %w(kkforum.makevoid.com), check: "phpbb", type: :php },
  munin:
    { domains: %w(munin.makevoid.com), type: :static },
  uploads:
    { domains: %w(uploads.makevoid.com), type: :static },
}