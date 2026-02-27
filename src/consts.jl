const latex_string_replacements = [
    "\\alpha"      => "\\textit{\\alpha}",   "\\otheralpha"   => "\\text{\\alpha}",
    "\\beta"       => "\\textit{\\beta}",    "\\otherbeta"    => "\\text{\\beta}",
    "\\zeta"       => "\\textit{\\zeta}",    "\\otherzeta"    => "\\text{\\zeta}",
    "\\eta"        => "\\textit{\\eta}",     "\\othereta"     => "\\text{\\eta}",
    "\\iota"       => "\\textit{\\iota}",    "\\otheriota"    => "\\text{\\iota}",
    "\\mu"         => "\\textit{\\mu}",      "\\othermu"      => "\\text{\\mu}",
    "\\nu"         => "\\textit{\\nu}",      "\\othernu"      => "\\text{\\nu}",
    "\\tau"        => "\\textit{\\tau}",     "\\othertau"     => "\\text{\\tau}",
    "\\chi"        => "\\textit{\\chi}",     "\\otherchi"     => "\\text{\\chi}",
    "\\gamma"      => "\\textit{\\gamma}",   "\\othergamma"   => "\\text{\\gamma}",   "\\Gamma"   => "\\text{\\Gamma}",   "\\otherGamma"   => "\\textit{\\Gamma}",
    "\\delta"      => "\\textit{\\delta}",   "\\otherdelta"   => "\\text{\\delta}",   "\\Delta"   => "\\text{\\Delta}",   "\\otherDelta"   => "\\textit{\\Delta}",
    "\\lambda"     => "\\textit{\\lambda}",  "\\otherlambda"  => "\\text{\\lambda}",  "\\Lambda"  => "\\text{\\Lambda}",  "\\otherLambda"  => "\\textit{\\Lambda}",
    "\\xi"         => "\\textit{\\xi}",      "\\otherxi"      => "\\text{\\xi}",      "\\Xi"      => "\\text{\\Xi}",      "\\otherXi"      => "\\textit{\\Xi}",
    "\\upsilon"    => "\\textit{\\upsilon}", "\\otherupsilon" => "\\text{\\upsilon}", "\\Upsilon" => "\\text{\\Upsilon}", "\\otherUpsilon" => "\\textit{\\Upsilon}",
    "\\psi"        => "\\textit{\\psi}",     "\\otherpsi"     => "\\text{\\psi}",     "\\Psi"     => "\\text{\\Psi}",     "\\otherPsi"     => "\\textit{\\Psi}",
    "\\omega"      => "\\textit{\\omega}",   "\\otheromega"   => "\\text{\\omega}",   "\\Omega"   => "\\text{\\Omega}",   "\\otherOmega"   => "\\textit{\\Omega}",
    "\\theta"      => "\\textit{\\theta}",   "\\othertheta"   => "\\text{\\theta}",   "\\Theta"   => "\\text{\\Theta}",   "\\otherTheta"   => "\\textit{\\Theta}", "\\vartheta"   => "\\textit{\\vartheta}",   "\\othervartheta"   => "\\text{\\vartheta}",   
    "\\pi"         => "\\textit{\\pi}",      "\\otherpi"      => "\\text{\\pi}",      "\\Pi"      => "\\text{\\Pi}",      "\\otherPi"      => "\\textit{\\Pi}",    "\\varpi"      => "\\textit{\\varpi}",      "\\othervarpi"      => "\\text{\\varpi}",      
    "\\sigma"      => "\\textit{\\sigma}",   "\\othersigma"   => "\\text{\\sigma}",   "\\Sigma"   => "\\text{\\Sigma}",   "\\otherSigma"   => "\\textit{\\Sigma}", "\\varsigma"   => "\\textit{\\varsigma}",   "\\othervarsigma"   => "\\text{\\varsigma}",   
    "\\phi"        => "\\textit{\\phi}",     "\\otherphi"     => "\\text{\\phi}",     "\\Phi"     => "\\text{\\Phi}",     "\\otherPhi"     => "\\textit{\\Phi}",   "\\varphi"     => "\\textit{\\varphi}",     "\\othervarphi"     => "\\text{\\varphi}",     
    "\\epsilon"    => "\\textit{\\epsilon}", "\\otherepsilon" => "\\text{\\epsilon}",                                                                              "\\varepsilon" => "\\textit{\\varepsilon}", "\\othervarepsilon" => "\\text{\\varepsilon}",
    "\\kappa"      => "\\textit{\\kappa}",   "\\otherkappa"   => "\\text{\\kappa}",                                                                                "\\varkappa"   => "\\textit{\\varkappa}",   "\\othervarkappa"   => "\\text{\\varkappa}",
    "\\rho"        => "\\textit{\\rho}",     "\\otherrho"     => "\\text{\\rho}",                                                                                  "\\varrho"     => "\\textit{\\varrho}",     "\\othervarrho"     => "\\text{\\varrho}",

    "+"            => "\\textit{+}",
    "-"            => "\\textit{-}",
    "\\pm"         => "\\textit{\\pm}",
    "="            => "\\textit{=}",
    "\\times"      => "\\textit{\\times}",
    "\\div"        => "\\textit{\\div}",
    "°"            => "\\textit{°}",
    "\\AA"         => "\\text{\\AA}"
]
 
 
 
