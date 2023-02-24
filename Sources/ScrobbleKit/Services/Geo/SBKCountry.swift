//
//  SBKCountry.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

public enum SBKCountry: String, CaseIterable {
    case afghanistan = "Afghanistan"
    case albania = "Albania"
    case algeria = "Algeria"
    case americanSamoa = "American Samoa"
    case andorra = "Andorra"
    case angola = "Angola"
    case anguilla = "Anguilla"
    case antarctica = "Antarctica"
    case antiguaAndBarbuda = "Antigua and Barbuda"
    case argentina = "Argentina"
    case armenia = "Armenia"
    case aruba = "Aruba"
    case australia = "Australia"
    case austria = "Austria"
    case azerbaijan = "Azerbaijan"
    case bahamas = "Bahamas"
    case bahrain = "Bahrain"
    case bangladesh = "Bangladesh"
    case barbados = "Barbados"
    case belarus = "Belarus"
    case belgium = "Belgium"
    case belize = "Belize"
    case benin = "Benin"
    case bermuda = "Bermuda"
    case bhutan = "Bhutan"
    case bolivia = "Bolivia"
    case bosniaAndHerzegovina = "Bosnia and Herzegovina"
    case botswana = "Botswana"
    case bouvetIsland = "Bouvet Island"
    case brazil = "Brazil"
    case britishIndianOceanTerritory = "British Indian Ocean Territory"
    case bruneiDarussalam = "Brunei Darussalam"
    case bulgaria = "Bulgaria"
    case burkinaFaso = "Burkina Faso"
    case burundi = "Burundi"
    case capeVerde = "Cape Verde"
    case cambodia = "Cambodia"
    case cameroon = "Cameroon"
    case canada = "Canada"
    case caymanIslands = "Cayman Islands"
    case centralAfricanRepublic = "Central African Republic"
    case chad = "Chad"
    case chile = "Chile"
    case china = "China"
    case christmasIsland = "Christmas Island"
    case cocosKeelingIslands = "Cocos (Keeling) Islands"
    case colombia = "Colombia"
    case comoros = "Comoros"
    case congo = "Congo"
    case cookIslands = "Cook Islands"
    case costaRica = "Costa Rica"
    case croatia = "Croatia"
    case cuba = "Cuba"
    case curacao = "Curaçao"
    case cyprus = "Cyprus"
    case czechia = "Czech Republic"
    case denmark = "Denmark"
    case djibouti = "Djibouti"
    case dominica = "Dominica"
    case dominicanRepublic = "Dominican Republic"
    case ecuador = "Ecuador"
    case egypt = "Egypt"
    case elSalvador = "El Salvador"
    case equatorialGuinea = "Equatorial Guinea"
    case eritrea = "Eritrea"
    case estonia = "Estonia"
    /// Formerly named as Swaziland
    case eswatini = "Swaziland"
    case ethiopia = "Ethiopia"
    case falklandIslands = "Falkland Islands (Malvinas)"
    case faroeIslands = "Faroe Islands"
    case fiji = "Fiji"
    case finland = "Finland"
    case france = "France"
    case frenchGuiana = "French Guiana"
    case frenchPolynesia = "French Polynesia"
    case frenchSouthernTerritories = "French Southern Territories"
    case gabon = "Gabon"
    case gambia = "Gambia"
    case georgia = "Georgia"
    case germany = "Germany"
    case ghana = "Ghana"
    case gibraltar = "Gibraltar"
    case greece = "Greece"
    case greenland = "Greenland"
    case grenada = "Grenada"
    case guadeloupe = "Guadeloupe"
    case guam = "Guam"
    case guatemala = "Guatemala"
    case guernsey = "Guernsey"
    case guinea = "Guinea"
    case guineaBissau = "Guinea-Bissau"
    case guyana = "Guyana"
    case haiti = "Haiti"
    case heardIslandAndMcDonaldIslands = "Heard Island and McDonald Islands"
    case honduras = "Honduras"
    case hongKong = "Hong Kong"
    case hungary = "Hungary"
    case iceland = "Iceland"
    case india = "India"
    case indonesia = "Indonesia"
    case iranIslamicRepublicOf = "Iran, Islamic Republic of"
    case iraq = "Iraq"
    case ireland = "Ireland"
    case isleOfMan = "Isle of Man"
    case israel = "Israel"
    case italy = "Italy"
    case jamaica = "Jamaica"
    case japan = "Japan"
    case jersey = "Jersey"
    case jordan = "Jordan"
    case kazakhstan = "Kazakhstan"
    case kenya = "Kenya"
    case kiribati = "Kiribati"
    case kuwait = "Kuwait"
    case kyrgyzstan = "Kyrgyzstan"
    case laoPeopleSDemocraticRepublic = "Lao People's Democratic Republic"
    case latvia = "Latvia"
    case lebanon = "Lebanon"
    case lesotho = "Lesotho"
    case liberia = "Liberia"
    case liechtenstein = "Liechtenstein"
    case lithuania = "Lithuania"
    case luxembourg = "Luxembourg"
    case madagascar = "Madagascar"
    case malawi = "Malawi"
    case malaysia = "Malaysia"
    case maldives = "Maldives"
    case mali = "Mali"
    case malta = "Malta"
    case marshallIslands = "Marshall Islands"
    case martinique = "Martinique"
    case mauritania = "Mauritania"
    case mauritius = "Mauritius"
    case mayotte = "Mayotte"
    case mexico = "Mexico"
    case micronesiaFederatedStatesOf = "Micronesia, Federated States of"
    case moldova = "Moldova"
    case monaco = "Monaco"
    case mongolia = "Mongolia"
    case montenegro = "Montenegro"
    case montserrat = "Montserrat"
    case morocco = "Morocco"
    case mozambique = "Mozambique"
    case myanmar = "Myanmar"
    case namibia = "Namibia"
    case nauru = "Nauru"
    case nepal = "Nepal"
    case netherlands = "Netherlands"
    case newCaledonia = "New Caledonia"
    case newZealand = "New Zealand"
    case nicaragua = "Nicaragua"
    case niger = "Niger"
    case nigeria = "Nigeria"
    case niue = "Niue"
    case norfolkIsland = "Norfolk Island"
    case northernMarianaIslands = "Northern Mariana Islands"
    case norway = "Norway"
    case oman = "Oman"
    case pakistan = "Pakistan"
    case palau = "Palau"
    case panama = "Panama"
    case papuaNewGuinea = "Papua New Guinea"
    case paraguay = "Paraguay"
    case peru = "Peru"
    case philippines = "Philippines"
    case pitcairn = "Pitcairn"
    case poland = "Poland"
    case portugal = "Portugal"
    case puertoRico = "Puerto Rico"
    case qatar = "Qatar"
    case romania = "Romania"
    case russia = "Russian Federation"
    case rwanda = "Rwanda"
    case samoa = "Samoa"
    case sanMarino = "San Marino"
    case saoTomeAndPrincipe = "Sao Tome and Principe"
    case saudiArabia = "Saudi Arabia"
    case senegal = "Senegal"
    case serbia = "Serbia"
    case seychelles = "Seychelles"
    case sierraLeone = "Sierra Leone"
    case singapore = "Singapore"
    case sintMaarten = "Sint Maarten"
    case slovakia = "Slovakia"
    case slovenia = "Slovenia"
    case solomonIslands = "Solomon Islands"
    case somalia = "Somalia"
    case southAfrica = "South Africa"
    case southGeorgiaAndTheSouthSandwichIslands = "South Georgia and the South Sandwich Islands"
    case southSudan = "South Sudan"
    case spain = "Spain"
    case sriLanka = "Sri Lanka"
    case sudan = "Sudan"
    case suriname = "Suriname"
    case svalbardAndJanMayen = "Svalbard and Jan Mayen"
    case sweden = "Sweden"
    case switzerland = "Switzerland"
    case syria = "Syrian Arab Republic"
    case taiwan = "Taiwan"
    case tajikistan = "Tajikistan"
    case tanzania = "Tanzania, United Republic of"
    case thailand = "Thailand"
    case timorLeste = "Timor-Leste"
    case togo = "Togo"
    case tokelau = "Tokelau"
    case tonga = "Tonga"
    case trinidadAndTobago = "Trinidad and Tobago"
    case tunisia = "Tunisia"
    case turkey = "Turkey"
    case turkmenistan = "Turkmenistan"
    case turksAndCaicosIslands = "Turks and Caicos Islands"
    case tuvalu = "Tuvalu"
    case uganda = "Uganda"
    case ukraine = "Ukraine"
    case unitedArabEmirates = "United Arab Emirates"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
    case unitedStatesMinorOutlyingIslands = "United States Minor Outlying Islands"
    case uruguay = "Uruguay"
    case uzbekistan = "Uzbekistan"
    case vanuatu = "Vanuatu"
    case venezuela = "Venezuela"
    case vietnam = "Viet Nam"
    case wallisAndFutuna = "Wallis and Futuna"
    case westernSahara = "Western Sahara"
    case yemen = "Yemen"
    case zambia = "Zambia"
    case zimbabwe = "Zimbabwe"
}
