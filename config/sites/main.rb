SITES = {

  # Main

  mkvd:
  { domains: %w(makevoid.com makevoid.net makevoid.it), check: "makevoid" },

  # FiveServ

  radioshout:
    { domains: %w(radioshout.mkvd.net radioshout.it), type: :fiveserv, check: "RadioShout" },
  fbconnect:
    { domains: %w(demo.mkvd.net), type: :fiveserv, check: "fbconnect" },

  fivetastic_presentation:
    { domains: %w(presentation.fivetastic.org), type: :fiveserv, check: "@makevoid" },

  fivetastic:
    { domains: %w(demo.fivetastic.org), type: :fiveserv, check: "EDIT ME" },
  :"fivetastic-site" =>
    { domains: %w(fivetastic.org), type: :fiveserv, check: "EDIT ME" },
  # archipunto:
  #   { domains: %w(archipunto.mkvd.net studioarchipunto.it), type: :fiveserv, check: "Archipunto" },
  riotvan:
    { domains: %w(riotvan.net new.riotvan.net), type: :fiveserv, check: "RiotVan" },
  rvideo:
    { domains: %w(video.riotvan.net), type: :fiveserv, check: "RiotVan Video" },
  # bitclan:
  #   { domains: %w(bitclan.it), type: :fiveserv, check: "BIT" },



  # Rack

  makevoid:
    { domains: %w(updates.makevoid.com updates.makevoid.net updates.makevoid.it), check: "makevoid's blog" },

  fcanessa:
    { domains: %w(francescocanessa.com), check: "Francesco Canessa" },

  sinforum:
    { domains: %w(bitclan.it), check: "BIT" },
  # rankey:
  #   { domains: %w(rankey.it) },

  wargame:
      { domains: %w(wargame.mkvd.net), check: "WarGame" },

  headshot:
      { domains: %w(hshot.mkvd.net), check: "HShot" },

  skicams:
    { domains: %w(skicams.it), check: "SkiCams.it - Le webcam" },

  github:
    { domains: %w(github.it), access: true },

  trysinatra:
    { domains: %w(trysinatra.makevoid.com trysinatra.org), check: "TrySinatra" },

  # mplate:
  # { domains: %w(mplate.org mplate.makevoid.com), check: "MPlate" },

  # revoluted:
  # { domains: %w(revoluted.org revoluted.makevoid.com), check: "Revoluted" },


  # no vhost neededs
  # jscrape:
  #   { domains: %w(jscrape.makevoid.com) },

  jscrapeweb:
    { domains: %w(jscrape.it jscrape.makevoid.com), check: "jScrape" },




  whoisy:
    { domains: %w(whoisy.net whoisy.makevoid.com), check: "Whoisy" },
  # stylequiz:
  #   { domains: %w(stylequiz.makevoid.com stylequiz.net stylequiz.org), check: "StyleQuiz" },

  volatutto:
    { domains: %w(volatutto.mkvd.net), check: "vola tutto" },

  thorrents:
    { domains: %w(thorrents.com thorrents.makevoid.com), check: "Thorrents" },

  cappiello:
    { domains: %w(accademia-cappiello.it accademiacappiello.it cappiello.makevoid.com), check: "Design Leonetto Cappiello" },
  pp:
    { domains: %w(pietroporcinai.net pietroporcinai.com pietroporcinai.it), check: "Pietro Porcinai" },


  autogo:
    { domains: %w(autogo.eu oala.autogo.eu), check: ["sistema di appuntamenti", "Prenota la tua revisione"] },

  # sc2profiles:
  #   { domains: %w(sc2profiles.makevoid.com), check: "<th>Rank<\/th>" },

  # pmanage:
  #   { domains: %w(rom.makevoid.com), check: "ROM" },

  wsroomers:
    { domains: %w(willowstreetroomers.com), check: "Willow Street Roomers" },

  handsonxp:
    { domains: %w(handsonxp.com), check: "Hands-on" },




  mangapad:
    { domains: %w(mangapad.org), check: "Mangapad" },
  # repshare:
  #   { domains: %w(repshare.makevoid.com repshare.org), check: "Repshare" },

  # kombat:
  #   { domains: %w(kombat.makevoid.com), check: "Kombat" },

  # multip:
  #   { domains: %w(multipromo.makevoid.com multip.makevoid.com multipromo.com), check: "MultiPromo" },
  eli:
    { domains: %w(elisabettaporcinai.com), check: "Elisabetta Porcinai" },
  krikri:
    { domains: %w(kristinabutkute.com), check: "Kristina Butkute\'s website" },


  munin:
    { domains: %w(munin.makevoid.com), type: :static, check: "Overview" },

  # nomasvello:
  #   { domains: %w(nomasvello.makevoid.com), check: "NoMasVello" },
  medoro:
    { domains: %w(giannimedoro.it medoro.makevoid.com), check: "Gianni Medoro" },

  # neroseppia:
  #   { domains: %w(officineneroseppia.com), check: "Officine Nero Seppia" },

  uploads:
    { domains: %w(uploads.makevoid.com), type: :static, check: "Nothing to see here" },

  fiveapi:
    { domains: %w(fiveapi.com), check: "FiveAPI" },

  rubymotion_it:
    { domains: %w(rubymotion.it), check: "RubyMotion" },

}