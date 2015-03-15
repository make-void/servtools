SITES = {

  # Main

  mkvd:
  { domains: %w(makevoid.com makevoid.net makevoid.it mkvd.net), check: "makevoid" },

  # ortuino:
  #   { domains: %w(ortuino.com), check: "Ortuino" },

  fivecms: { domains: %w(fivecms.mkvd.net) }, # fivecms.com

  yourender:
    { domains: %w(yourender.it), check: "YouRender" }, # todo: open it

  bitcoin_exchange:
    { domains: %w(lemontree.io), check: "Lemontree" },

  donacoin_web:
    { domains: %w(donacoin.com), check: "Donacoin" },

  # ortuino:
  #   { domains: %w(ortuino.mkvd.net), check: "Ortuino" }, # ortuino.com

  radioshout:
    { domains: %w(radioshout.mkvd.net radioshout.it), cache: false, check: "RadioShout" },

  # upandcoming:
  #     { domains: %w(upandcoming.mkvd.net), cache: false, check: "upandcoming" },

  # cuestionario:
  #    { domains: %w(cuestionario.mkvd.net eurosolar.mkvd.net), check: "URB-AL" },

  paolap:
     { domains: %w(paolaporcinai.it paolap.mkvd.net), check: "Paola" },

  cool_chic_living:
     { domains: %w(coolchicliving.com), check: "Cool" },


  # FiveServ

  :"3dmaking" =>
     { domains: %w(3dmaking.it), type: :fiveserv, check: "3DMaking" },

  up_gallery:
     { domains: %w(upgal.mkvd.net), type: :fiveserv },

  ffos_maps:
     { domains: %w(maps.makevoid.com), type: :fiveserv },

  ffos_notes:
     { domains: %w(notes.makevoid.com) },

  :"3dmaking" =>
     { domains: %w(3dmaking.it), check: "3D Making" },

  fbconnect:
    { domains: %w(fbconnect.mkvd.net), type: :fiveserv, check: "fbconnect" },

  code_it_from_scratch:
    { domains: %w(cifs.mkvd.net rubyday13.mkvd.net), check: "fullscreen" },

  bitcoin_bath_lt:
    { domains: %w(bitbath.mkvd.net bitcoin_bath.mkvd.net), check: "fullscreen" },


  fivetastic_presentation:
    { domains: %w(fivetastic.mkvd.net), type: :fiveserv, check: "@makevoid" },

  taxiweb:
    { domains: %w(taxiweb.makevoid.com), check: "TaxiWeb" },

  rcanessa:
    { domains: %w(old.gaiaconsult.eu robertocanessa.eu), check: "GAIA" },

  gaia_ghost:
    { domains: %w(gaiaconsult.eu), check: "GAIA" },

  # istatap:
  #   { domains: %w(istatap.mkvd.net), type: :fiveserv},

  # pres_ruby2:
  #   { domains: %w(ruby2pres.makevoid.com), type: :fiveserv, check: "@makevoid" },


  fivetastic:
    { domains: %w(demo-fivetastic.makevoid.com), type: :fiveserv, check: "EDIT ME" },
  :"fivetastic-site" =>
    { domains: %w(fivetastic.makevoid.com), type: :fiveserv, check: "EDIT ME" },
  # archipunto:
  #   { domains: %w(archipunto.mkvd.net studioarchipunto.it), type: :fiveserv, check: "Archipunto" },
  rvideo:
    { domains: %w(video.riotvan.net), type: :fiveserv, check: "RiotVan Video" },
  # bitclan:
  #   { domains: %w(bitclan.it), type: :fiveserv, check: "BIT" },

  s3photos:
    { domains: %w(s3photos.makevoid.com), type: :fiveserv, check: "s3photos" }, # http://s3photos.makevoid.com/nodump_crisi


  # Rack

  makevoid:
    { domains: %w(updates.makevoid.com updates.makevoid.net updates.makevoid.it), check: "makevoid's blog" },

  fcanessa:
    { domains: %w(francescocanessa.com), check: "Francesco Canessa" },

  autoproduce:
    { domains: %w(autoproduce.mkvd.net),  check: "Autoproduce" }, # autoproduce.it

  riotvan:
    { domains: %w(riotvan.net new.riotvan.net old.riotvan.net),  check: "RiotVan" },

  sinforum:
    { domains: %w(bitclan.it sinforum.mkvd.net), check: "BIT" },
  # rankey:
  #   { domains: %w(rankey.it) },

  wargame:
      { domains: %w(wargame.mkvd.net), check: "WarGame" },

  # headshot:
  #     { domains: %w(hshot.mkvd.net), check: "HShot" },

  skicams:
    { domains: %w(skicams.it), check: "SkiCams.it - Le webcam" },

  github:
    { domains: %w(github.it), access: true },

  # trysinatra:
  #   { domains: %w(trysinatra.makevoid.com), check: "TrySinatra" }, #  trysinatra.org

  gis:
    { domains: %w(gis.makevoid.com), check: "GIS" },

  # mplate:
  # { domains: %w(mplate.org mplate.makevoid.com), check: "MPlate" },

  # revoluted:
  # { domains: %w(revoluted.org revoluted.makevoid.com), check: "Revoluted" },


  # no vhost neededs
  # jscrape:
  #   { domains: %w(jscrape.makevoid.com) },

  jscrapeweb:
    { domains: %w(jscrape.makevoid.com), check: "jScrape" }, # jscrape.it

  whoisy:
    { domains: %w(whoisy.net whoisy.makevoid.com), check: "Whoisy" },
  # stylequiz:
  #   { domains: %w(stylequiz.makevoid.com stylequiz.net stylequiz.org), check: "StyleQuiz" },

  # volatutto:
  #   { domains: %w(volatutto.mkvd.net), check: "vola tutto" },

  thorrents:
    { domains: %w(thorrents.makevoid.com thorrents.com), check: "Thorrents" },

  cafp_ruby:
    { domains: %w(cafp-makevoid.mkvd.net), check: "CAFP" },

  cappiello:
    { domains: %w(accademia-cappiello.it accademiacappiello.it cappiello.makevoid.com), check: "Design Leonetto Cappiello" },

  # cappiello_staging:
  #   { domains: %w(staging.accademiacappiello.it), env: "staging", check: "Design Leonetto Cappiello" },

  pp:
    { domains: %w(pietroporcinai.net pietroporcinai.com pietroporcinai.it), check: "Pietro Porcinai" },

  autogo:
    { domains: %w(autogo.eu oala.autogo.eu), check: ["sistema di appuntamenti", "Prenota la tua revisione"] },

  # sc2profiles:
  #   { domains: %w(sc2profiles.makevoid.com), check: "<th>Rank<\/th>" },

  # pmanage:
  #   { domains: %w(rom.makevoid.com), check: "ROM" },

  # wsroomers:
  #   { domains: %w(willowstreetroomers.mkvd.net), check: "Willow Street Roomers" }, # willowstreetroomers.com

  handsonxp:
    { domains: %w(handsonxp.com), check: "Hands-on" },

  # mangapad:
  #   { domains: %w(mangapad.org), check: "Mangapad", cache: false },

  # repshare:
  #   { domains: %w(repshare.makevoid.com repshare.org), check: "Repshare" },

  # kombat:
  #   { domains: %w(kombat.makevoid.com), check: "Kombat" },

  # multip:
  #   { domains: %w(multipromo.makevoid.com multip.makevoid.com multipromo.com), check: "MultiPromo" },
  nushape:
    { domains: %w(nush.it nushape.mkvd.net), check: "nush" },

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

  ltestudio:
    { domains: %w(ltestudio.makevoid.com), check: "LTE Studio" },

  tencard:
    { domains: %w(tencard.makevoid.com), check: "10Card" },

  gmaps_gis:
    { domains: %w(gmaps-gis.mkvd.net), check: "GIS" },

  # decibel:
  #   { domains: %w(decibel.makevoid.com), check: "Decibel Eventi" },

  marcomazzi:
    { domains: %w(marcomazzi.mkvd.net), check: "Marco Mazzi" },

  shampy:
    { domains: %w(shampy.mkvd.net) },

  s3play:
    { domains: %w(s3play.it s3play.makevoid.com), check: "S3Play" },

  psyjs:
    { domains: %w(psyjs.mkvd.net) },

  estemporary:
    { domains: %w(estemporary.com), check: "EsTemporary" },

  hostgist:
    { domains: %w(hostgist.makevoid.com) },

  icchettu:
    { domains: %w(icchettu.makevoid.com) },

  # redilogger:
  #   { domains: %w(offerte-lavoro.blogsite.org) },
}
