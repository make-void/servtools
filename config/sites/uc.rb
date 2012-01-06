SITES = {
  
  ucrm: 
    { domains: %w(gystyle.mobi), check: "Accedi" },

  ucrm_old: 
    { domains: %w(uc.gystyle.mobi ucrm.mkvd.net), env: "production_old", check: "Accedi" },

  rankey: 
    { domains: %w(rankey.it rankey.mkvd.net), check: "Login" },
    
}