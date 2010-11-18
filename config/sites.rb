# defaults: { type: :rack }
SITES = {
  defaulter:  
    { domains: %w(qntrol.com), check: "404 - Page not found", catchall: true },
  autogo:
    { domains: %w(autogo.eu oala.autogo.eu), check: "Prenota la tua revisione" },
  sc2profiles:
    { domains: %w(sc2profiles.makevoid.com), check: "<th>Rank<\/th>" },
  kombat:
    { domains: %w(kombat.makevoid.com), check: "Kombat" },
  vstaging:
    { domains: %w(vstaging.makevoid.com), check: "Versus \(staging\)", env: "staging" },
  makevoid:
    { domains: %w(makevoid.com makevoid.net makevoid.it francescocanessa.com), check: "makevoid's blog" },
  # pingaholic:
  #   { domains: %w(pingaholic.com) },
  munin:
    { domains: %w(munin.makevoid.com), type: :static },
  skicams:
    { domains: %w(skicams.it), check: "SkiCams.it - Le webcam" },
  uploads:
    { domains: %w(uploads.makevoid.com), type: :static },
  cohesionsocial:
    { domains: %w(erasmusquestionnaire.eu), check: "Erasmus Questionnaire" },
  repshare:
    { domains: %w(repshare.org), check: "Repshare" },
  pp:
    { domains: %w(pietroporcinai.net pietroporcinai.com pietroporcinai.it), check: "Pietro Porcinai" },
  mangapad:
    { domains: %w(mangapad.org), check: "Mangapad" },
  wsroomers:
    { domains: %w(willowstreetroomers.com), check: "Willow Street Roomers" },
  neroseppia:
    { domains: %w(officineneroseppia.com), check: "Officine Nero Seppia" },
  versus:
    { domains: %w(versus.new-tv.it versus.makevoid.com), min_instances: 2, check: "Versus" },
  krikri:
    { domains: %w(kristinabutkute.com), check: "Kristina Butkute\'s website" },
  cohesionsocial_staff:
    { domains: %w(staff.erasmusquestionnaire.eu), check: "Erasmus Questionnaire", env: "production_staff" },
  
}