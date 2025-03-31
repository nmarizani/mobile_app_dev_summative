import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/theme/theme.dart';
import '../../widgets/bottom_nav_bar.dart';

class ProfileShippingScreen extends StatefulWidget {
  const ProfileShippingScreen({super.key});

  @override
  State<ProfileShippingScreen> createState() => _ProfileShippingScreenState();
}

class _ProfileShippingScreenState extends State<ProfileShippingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;
  String _selectedCountry = 'Kenya';

  // Map of African countries with their country codes and flag emojis
  final Map<String, Map<String, String>> _countries = {
    'Kenya': {'code': '+254', 'flag': '🇰🇪'},
    'Nigeria': {'code': '+234', 'flag': '🇳🇬'},
    'South Africa': {'code': '+27', 'flag': '🇿🇦'},
    'Egypt': {'code': '+20', 'flag': '🇪🇬'},
    'Morocco': {'code': '+212', 'flag': '🇲🇦'},
    'Ghana': {'code': '+233', 'flag': '🇬🇭'},
    'Tanzania': {'code': '+255', 'flag': '🇹🇿'},
    'Ethiopia': {'code': '+251', 'flag': '🇪🇹'},
    'Uganda': {'code': '+256', 'flag': '🇺🇬'},
    'Algeria': {'code': '+213', 'flag': '🇩🇿'},
    'Sudan': {'code': '+249', 'flag': '🇸🇩'},
    'Libya': {'code': '+218', 'flag': '🇱🇾'},
    'Tunisia': {'code': '+216', 'flag': '🇹🇳'},
    'Angola': {'code': '+244', 'flag': '🇦🇴'},
    'Zimbabwe': {'code': '+263', 'flag': '🇿🇼'},
    'Cameroon': {'code': '+237', 'flag': '🇨🇲'},
    'Côte d\'Ivoire': {'code': '+225', 'flag': '🇨🇮'},
    'Senegal': {'code': '+221', 'flag': '🇸🇳'},
    'Mali': {'code': '+223', 'flag': '🇲🇱'},
    'Rwanda': {'code': '+250', 'flag': '🇷🇼'},
  };

  // Map of provinces/regions for each country
  final Map<String, List<String>> _provinces = {
    'Kenya': [
      'Nairobi',
      'Coast',
      'Central',
      'Eastern',
      'North Eastern',
      'Nyanza',
      'Rift Valley',
      'Western'
    ],
    'Nigeria': [
      'Lagos',
      'Abuja FCT',
      'Rivers',
      'Kano',
      'Oyo',
      'Delta',
      'Kaduna',
      'Ogun'
    ],
    'South Africa': [
      'Gauteng',
      'Western Cape',
      'KwaZulu-Natal',
      'Eastern Cape',
      'Free State',
      'Mpumalanga',
      'North West',
      'Limpopo',
      'Northern Cape'
    ],
    'Egypt': [
      'Cairo',
      'Alexandria',
      'Giza',
      'Qalyubia',
      'Gharbia',
      'Dakahlia',
      'Sharqia',
      'Beheira'
    ],
    'Morocco': [
      'Casablanca-Settat',
      'Rabat-Salé-Kénitra',
      'Tangier-Tetouan-Al Hoceima',
      'Fès-Meknès',
      'Marrakesh-Safi',
      'Oriental',
      'Béni Mellal-Khénifra'
    ],
    'Ghana': [
      'Greater Accra',
      'Ashanti',
      'Western',
      'Eastern',
      'Central',
      'Northern',
      'Volta',
      'Brong-Ahafo'
    ],
    'Tanzania': [
      'Dar es Salaam',
      'Dodoma',
      'Arusha',
      'Mwanza',
      'Zanzibar',
      'Tanga',
      'Morogoro',
      'Mbeya'
    ],
    'Ethiopia': [
      'Addis Ababa',
      'Dire Dawa',
      'Amhara',
      'Oromia',
      'SNNPR',
      'Somali',
      'Afar',
      'Benishangul-Gumuz'
    ],
    'Uganda': [
      'Central',
      'Eastern',
      'Northern',
      'Western',
      'Kampala',
      'Wakiso',
      'Mukono',
      'Jinja'
    ],
    'Algeria': [
      'Algiers',
      'Oran',
      'Constantine',
      'Annaba',
      'Blida',
      'Setif',
      'Béjaïa',
      'Biskra'
    ],
    'Sudan': [
      'Khartoum',
      'Omdurman',
      'Port Sudan',
      'Kassala',
      'El Obeid',
      'Wad Madani',
      'Al-Fashir',
      'Nyala'
    ],
    'Libya': [
      'Tripoli',
      'Benghazi',
      'Misrata',
      'Bayda',
      'Zawiya',
      'Sabha',
      'Tobruk',
      'Sirte'
    ],
    'Tunisia': [
      'Tunis',
      'Sfax',
      'Sousse',
      'Kairouan',
      'Bizerte',
      'Gabès',
      'Ariana',
      'Nabeul'
    ],
    'Angola': [
      'Luanda',
      'Huambo',
      'Benguela',
      'Lubango',
      'Malanje',
      'Uíge',
      'Cabinda',
      'Namibe'
    ],
    'Zimbabwe': [
      'Harare',
      'Bulawayo',
      'Chitungwiza',
      'Mutare',
      'Gweru',
      'Kwekwe',
      'Kadoma',
      'Masvingo'
    ],
    'Cameroon': [
      'Douala',
      'Yaoundé',
      'Garoua',
      'Bamenda',
      'Bafoussam',
      'Maroua',
      'Ngaoundéré',
      'Bertoua'
    ],
    'Côte d\'Ivoire': [
      'Abidjan',
      'Bouaké',
      'Daloa',
      'Korhogo',
      'San-Pédro',
      'Yamoussoukro',
      'Man',
      'Divo'
    ],
    'Senegal': [
      'Dakar',
      'Touba',
      'Thiès',
      'Rufisque',
      'Kaolack',
      'Mbour',
      'Saint-Louis',
      'Ziguinchor'
    ],
    'Mali': [
      'Bamako',
      'Sikasso',
      'Mopti',
      'Koutiala',
      'Ségou',
      'Kayes',
      'Gao',
      'Timbuktu'
    ],
    'Rwanda': [
      'Kigali',
      'Butare',
      'Gitarama',
      'Ruhengeri',
      'Gisenyi',
      'Byumba',
      'Cyangugu',
      'Kibuye'
    ]
  };

  // Map of cities for each province
  final Map<String, Map<String, List<String>>> _cities = {
    'Kenya': {
      'Nairobi': ['Nairobi CBD', 'Westlands', 'Karen', 'Eastleigh', 'Kasarani'],
      'Coast': ['Mombasa', 'Malindi', 'Kilifi', 'Lamu', 'Diani'],
      'Central': ['Nyeri', 'Kiambu', 'Thika', 'Muranga', 'Kerugoya'],
      'Eastern': ['Meru', 'Embu', 'Machakos', 'Kitui', 'Isiolo'],
      'North Eastern': ['Garissa', 'Wajir', 'Mandera'],
      'Nyanza': ['Kisumu', 'Homa Bay', 'Kisii', 'Siaya', 'Migori'],
      'Rift Valley': ['Nakuru', 'Eldoret', 'Naivasha', 'Narok', 'Kericho'],
      'Western': ['Kakamega', 'Bungoma', 'Busia', 'Vihiga']
    },
    'Nigeria': {
      'Lagos': ['Lagos Island', 'Victoria Island', 'Ikoyi', 'Lekki', 'Ajah'],
      'Abuja FCT': ['Garki', 'Wuse', 'Maitama', 'Asokoro', 'Gwarinpa'],
      'Rivers': ['Port Harcourt', 'Obio/Akpor', 'Eleme', 'Okrika', 'Bonny'],
      'Kano': ['Kano City', 'Fagge', 'Sabon Gari', 'Bompai', 'Sharada'],
      'Oyo': ['Ibadan', 'Ogbomoso', 'Oyo', 'Iseyin', 'Saki'],
      'Delta': ['Warri', 'Asaba', 'Sapele', 'Ughelli', 'Effurun'],
      'Kaduna': ['Kaduna City', 'Zaria', 'Kafanchan', 'Kachia', 'Kagoro'],
      'Ogun': ['Abeokuta', 'Sagamu', 'Ijebu Ode', 'Ilaro', 'Ota']
    },
    'South Africa': {
      'Gauteng': ['Johannesburg', 'Pretoria', 'Soweto', 'Sandton', 'Boksburg'],
      'Western Cape': [
        'Cape Town',
        'Stellenbosch',
        'Paarl',
        'Strand',
        'Bellville'
      ],
      'KwaZulu-Natal': [
        'Durban',
        'Pietermaritzburg',
        'Umhlanga',
        'Ballito',
        'Pinetown'
      ],
      'Eastern Cape': [
        'Port Elizabeth',
        'East London',
        'Uitenhage',
        'Queenstown',
        'Grahamstown'
      ],
      'Free State': [
        'Bloemfontein',
        'Welkom',
        'Kroonstad',
        'Bethlehem',
        'Sasolburg'
      ],
      'Mpumalanga': ['Nelspruit', 'Witbank', 'Secunda', 'Standerton', 'Bethal'],
      'North West': [
        'Rustenburg',
        'Potchefstroom',
        'Klerksdorp',
        'Mahikeng',
        'Brits'
      ],
      'Limpopo': [
        'Polokwane',
        'Tzaneen',
        'Phalaborwa',
        'Louis Trichardt',
        'Mokopane'
      ],
      'Northern Cape': [
        'Kimberley',
        'Upington',
        'Springbok',
        'De Aar',
        'Kuruman'
      ]
    },
    'Egypt': {
      'Cairo': [
        'Downtown Cairo',
        'Maadi',
        'Heliopolis',
        'Zamalek',
        'New Cairo'
      ],
      'Alexandria': [
        'Downtown Alexandria',
        'Stanley',
        'Sidi Gaber',
        'Smouha',
        'Miami'
      ],
      'Giza': ['Giza City', 'Dokki', 'Mohandessin', 'Agouza', 'Haram'],
      'Qalyubia': ['Banha', 'Qalyub', 'Shubra El Kheima', 'Khanka', 'Qaha'],
      'Gharbia': [
        'Tanta',
        'Mahalla El Kubra',
        'Kafr El-Zayat',
        'Zefta',
        'Basyoun'
      ],
      'Dakahlia': ['Mansoura', 'Talkha', 'Aga', 'Mit Ghamr', 'Belqas'],
      'Sharqia': [
        'Zagazig',
        '10th of Ramadan City',
        'Bilbeis',
        'Abu Hammad',
        'Faqous'
      ],
      'Beheira': [
        'Damanhour',
        'Kafr El-Dawwar',
        'Rashid',
        'Edku',
        'Abu El-Matamir'
      ]
    },
    'Morocco': {
      'Casablanca-Settat': [
        'Casablanca',
        'Mohammedia',
        'Benslimane',
        'Settat',
        'El Jadida'
      ],
      'Rabat-Salé-Kénitra': ['Rabat', 'Salé', 'Kénitra', 'Skhirate', 'Témara'],
      'Tangier-Tetouan-Al Hoceima': [
        'Tangier',
        'Tetouan',
        'Al Hoceima',
        'Larache',
        'Fahs-Anjra'
      ],
      'Fès-Meknès': ['Fès', 'Meknès', 'Sefrou', 'Moulay Yacoub', 'Ifrane'],
      'Marrakesh-Safi': [
        'Marrakesh',
        'Safi',
        'El Kelaa des Sraghna',
        'Essaouira',
        'Chichaoua'
      ],
      'Oriental': ['Oujda', 'Nador', 'Berkane', 'Taourirt', 'Guercif'],
      'Béni Mellal-Khénifra': [
        'Béni Mellal',
        'Khouribga',
        'Fquih Ben Salah',
        'Azilal',
        'Khenifra'
      ]
    },
    'Ghana': {
      'Greater Accra': ['Accra', 'Tema', 'Madina', 'Adenta', 'Labadi'],
      'Ashanti': ['Kumasi', 'Obuasi', 'Ejisu', 'Mampong', 'Konongo'],
      'Western': [
        'Sekondi-Takoradi',
        'Tarkwa',
        'Axim',
        'Agona Nkwanta',
        'Tikobo No. 1'
      ],
      'Eastern': ['Koforidua', 'Nkawkaw', 'Nsawam', 'Akropong', 'Somanya'],
      'Central': ['Cape Coast', 'Winneba', 'Mankessim', 'Kasoa', 'Swedru'],
      'Northern': ['Tamale', 'Yendi', 'Savelugu', 'Gushegu', 'Karaga'],
      'Volta': ['Ho', 'Keta', 'Hohoe', 'Kpando', 'Aflao'],
      'Brong-Ahafo': ['Sunyani', 'Berekum', 'Techiman', 'Bechem', 'Wenchi']
    },
    'Tanzania': {
      'Dar es Salaam': [
        'City Centre',
        'Kinondoni',
        'Ilala',
        'Temeke',
        'Ubungo'
      ],
      'Dodoma': ['City Centre', 'Chamwino', 'Kondoa', 'Mpwapwa', 'Kongwa'],
      'Arusha': ['City Centre', 'Njiro', 'Sakina', 'Themi', 'Sanawari'],
      'Mwanza': ['City Centre', 'Nyamagana', 'Ilemela', 'Nyamagana', 'Kirumba'],
      'Zanzibar': [
        'Stone Town',
        'Mwanakwerekwe',
        'Mikunguni',
        'Mwanakwerekwe',
        'Mikunguni'
      ],
      'Tanga': ['City Centre', 'Mabokweni', 'Mzingani', 'Usagara', 'Mabokweni'],
      'Morogoro': ['City Centre', 'Mazimbu', 'Kihonda', 'Mazimbu', 'Kihonda'],
      'Mbeya': ['City Centre', 'Ilemi', 'Isyesye', 'Ilemi', 'Isyesye']
    },
    'Ethiopia': {
      'Addis Ababa': ['Bole', 'Kirkos', 'Arada', 'Yeka', 'Lideta'],
      'Dire Dawa': ['City Centre', 'Gurgura', 'Dechatu', 'Gurgura', 'Dechatu'],
      'Amhara': [
        'Bahir Dar',
        'Gondar',
        'Dessie',
        'Debre Birhan',
        'Debre Markos'
      ],
      'Oromia': ['Adama', 'Jimma', 'Nekemte', 'Shashamane', 'Bishoftu'],
      'SNNPR': ['Hawassa', 'Dilla', 'Arba Minch', 'Dilla', 'Arba Minch'],
      'Somali': ['Jijiga', 'Gode', 'Dolo', 'Gode', 'Dolo'],
      'Afar': ['Semera', 'Dessie', 'Logiya', 'Dessie', 'Logiya'],
      'Benishangul-Gumuz': [
        'Asosa',
        'Gilgel Beles',
        'Mengistu',
        'Gilgel Beles',
        'Mengistu'
      ]
    },
    'Uganda': {
      'Central': ['Kampala', 'Entebbe', 'Mukono', 'Wakiso', 'Mpigi'],
      'Eastern': ['Jinja', 'Mbale', 'Tororo', 'Iganga', 'Busia'],
      'Northern': ['Gulu', 'Lira', 'Arua', 'Kitgum', 'Moyo'],
      'Western': ['Mbarara', 'Fort Portal', 'Kasese', 'Hoima', 'Masaka'],
      'Kampala': ['Central', 'Nakasero', 'Kololo', 'Nakasero', 'Kololo'],
      'Wakiso': ['Nansana', 'Kira', 'Entebbe', 'Kira', 'Entebbe'],
      'Mukono': ['Mukono Town', 'Namanve', 'Njeru', 'Namanve', 'Njeru'],
      'Jinja': ['Jinja Town', 'Bugembe', 'Mpumudde', 'Bugembe', 'Mpumudde']
    },
    'Algeria': {
      'Algiers': [
        'Bab Ezzouar',
        'Hussein Dey',
        'Bir Mourad Raïs',
        'Bouzareah',
        'Dar El Beïda'
      ],
      'Oran': [
        'Bir El Djir',
        'Es Sénia',
        'Bir El Djir',
        'Es Sénia',
        'Bir El Djir'
      ],
      'Constantine': [
        'El Khroub',
        'Hamma Bouziane',
        'El Khroub',
        'Hamma Bouziane',
        'El Khroub'
      ],
      'Annaba': ['El Bouni', 'El Hadjar', 'El Bouni', 'El Hadjar', 'El Bouni'],
      'Blida': ['Blida', 'Boufarik', 'Blida', 'Boufarik', 'Blida'],
      'Setif': ['Setif', 'El Eulma', 'Setif', 'El Eulma', 'Setif'],
      'Béjaïa': ['Béjaïa', 'Akbou', 'Béjaïa', 'Akbou', 'Béjaïa'],
      'Biskra': ['Biskra', 'Ouled Djellal', 'Biskra', 'Ouled Djellal', 'Biskra']
    },
    'Sudan': {
      'Khartoum': [
        'Khartoum City',
        'Omdurman',
        'Khartoum North',
        'Omdurman',
        'Khartoum North'
      ],
      'Omdurman': [
        'Omdurman City',
        'Al-Morada',
        'Al-Morada',
        'Al-Morada',
        'Al-Morada'
      ],
      'Port Sudan': ['Port Sudan City', 'Al-Gad', 'Al-Gad', 'Al-Gad', 'Al-Gad'],
      'Kassala': ['Kassala City', 'Al-Gad', 'Al-Gad', 'Al-Gad', 'Al-Gad'],
      'El Obeid': ['El Obeid City', 'Al-Gad', 'Al-Gad', 'Al-Gad', 'Al-Gad'],
      'Wad Madani': ['Wad Madani City', 'Al-Gad', 'Al-Gad', 'Al-Gad', 'Al-Gad'],
      'Al-Fashir': ['Al-Fashir City', 'Al-Gad', 'Al-Gad', 'Al-Gad', 'Al-Gad'],
      'Nyala': ['Nyala City', 'Al-Gad', 'Al-Gad', 'Al-Gad', 'Al-Gad']
    },
    'Libya': {
      'Tripoli': [
        'Tripoli City',
        'Ben Ashour',
        'Ben Ashour',
        'Ben Ashour',
        'Ben Ashour'
      ],
      'Benghazi': [
        'Benghazi City',
        'Al-Sabri',
        'Al-Sabri',
        'Al-Sabri',
        'Al-Sabri'
      ],
      'Misrata': [
        'Misrata City',
        'Al-Sabri',
        'Al-Sabri',
        'Al-Sabri',
        'Al-Sabri'
      ],
      'Bayda': ['Bayda City', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri'],
      'Zawiya': ['Zawiya City', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri'],
      'Sabha': ['Sabha City', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri'],
      'Tobruk': ['Tobruk City', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri'],
      'Sirte': ['Sirte City', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri', 'Al-Sabri']
    },
    'Tunisia': {
      'Tunis': ['Tunis City', 'La Marsa', 'La Marsa', 'La Marsa', 'La Marsa'],
      'Sfax': ['Sfax City', 'La Marsa', 'La Marsa', 'La Marsa', 'La Marsa'],
      'Sousse': ['Sousse City', 'La Marsa', 'La Marsa', 'La Marsa', 'La Marsa'],
      'Kairouan': [
        'Kairouan City',
        'La Marsa',
        'La Marsa',
        'La Marsa',
        'La Marsa'
      ],
      'Bizerte': [
        'Bizerte City',
        'La Marsa',
        'La Marsa',
        'La Marsa',
        'La Marsa'
      ],
      'Gabès': ['Gabès City', 'La Marsa', 'La Marsa', 'La Marsa', 'La Marsa'],
      'Ariana': ['Ariana City', 'La Marsa', 'La Marsa', 'La Marsa', 'La Marsa'],
      'Nabeul': ['Nabeul City', 'La Marsa', 'La Marsa', 'La Marsa', 'La Marsa']
    },
    'Angola': {
      'Luanda': ['Luanda City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Huambo': ['Huambo City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Benguela': ['Benguela City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Lubango': ['Lubango City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Malanje': ['Malanje City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Uíge': ['Uíge City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Cabinda': ['Cabinda City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga'],
      'Namibe': ['Namibe City', 'Cazenga', 'Cazenga', 'Cazenga', 'Cazenga']
    },
    'Zimbabwe': {
      'Harare': [
        'Harare City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Bulawayo': [
        'Bulawayo City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Chitungwiza': [
        'Chitungwiza City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Mutare': [
        'Mutare City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Gweru': [
        'Gweru City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Kwekwe': [
        'Kwekwe City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Kadoma': [
        'Kadoma City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ],
      'Masvingo': [
        'Masvingo City',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant',
        'Mount Pleasant'
      ]
    },
    'Cameroon': {
      'Douala': ['Douala City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Yaoundé': ['Yaoundé City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Garoua': ['Garoua City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Bamenda': ['Bamenda City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Bafoussam': ['Bafoussam City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Maroua': ['Maroua City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Ngaoundéré': ['Ngaoundéré City', 'Akwa', 'Akwa', 'Akwa', 'Akwa'],
      'Bertoua': ['Bertoua City', 'Akwa', 'Akwa', 'Akwa', 'Akwa']
    },
    'Côte d\'Ivoire': {
      'Abidjan': ['Abidjan City', 'Cocody', 'Cocody', 'Cocody', 'Cocody'],
      'Bouaké': ['Bouaké City', 'Cocody', 'Cocody', 'Cocody', 'Cocody'],
      'Daloa': ['Daloa City', 'Cocody', 'Cocody', 'Cocody', 'Cocody'],
      'Korhogo': ['Korhogo City', 'Cocody', 'Cocody', 'Cocody', 'Cocody'],
      'San-Pédro': ['San-Pédro City', 'Cocody', 'Cocody', 'Cocody', 'Cocody'],
      'Yamoussoukro': [
        'Yamoussoukro City',
        'Cocody',
        'Cocody',
        'Cocody',
        'Cocody'
      ],
      'Man': ['Man City', 'Cocody', 'Cocody', 'Cocody', 'Cocody'],
      'Divo': ['Divo City', 'Cocody', 'Cocody', 'Cocody', 'Cocody']
    },
    'Senegal': {
      'Dakar': ['Dakar City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Touba': ['Touba City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Thiès': ['Thiès City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Rufisque': ['Rufisque City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Kaolack': ['Kaolack City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Mbour': ['Mbour City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Saint-Louis': ['Saint-Louis City', 'Fann', 'Fann', 'Fann', 'Fann'],
      'Ziguinchor': ['Ziguinchor City', 'Fann', 'Fann', 'Fann', 'Fann']
    },
    'Mali': {
      'Bamako': [
        'Bamako City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Sikasso': [
        'Sikasso City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Mopti': [
        'Mopti City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Koutiala': [
        'Koutiala City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Ségou': [
        'Ségou City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Kayes': [
        'Kayes City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Gao': [
        'Gao City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ],
      'Timbuktu': [
        'Timbuktu City',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye',
        'Hamdallaye'
      ]
    },
    'Rwanda': {
      'Kigali': [
        'Kigali City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Butare': [
        'Butare City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Gitarama': [
        'Gitarama City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Ruhengeri': [
        'Ruhengeri City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Gisenyi': [
        'Gisenyi City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Byumba': [
        'Byumba City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Cyangugu': [
        'Cyangugu City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ],
      'Kibuye': [
        'Kibuye City',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura',
        'Kimihurura'
      ]
    }
  };

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    Widget? prefix,
  }) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Enter ${label.toLowerCase()}',
                hintStyle: TextStyle(
                  color: isDark ? Colors.white60 : Colors.grey[400],
                  fontSize: 14,
                ),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF21D4B4)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: prefix,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                ),
              ),
              child: DropdownButtonFormField<String>(
                value: value,
                items: items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: onChanged,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: InputBorder.none,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                dropdownColor: isDark ? Colors.grey[800] : Colors.white,
                validator: (value) => value == null
                    ? 'Please select ${label.toLowerCase()}'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildCountryDropdown() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedCountry,
                items: _countries.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          entry.value['flag']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          entry.value['code']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  }
                },
                underline: const SizedBox(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                dropdownColor: isDark ? Colors.grey[800] : Colors.white,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 1,
                height: 24,
                color: isDark ? Colors.grey[700] : Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFF21D4B4),
            elevation: 0,
            title: const Text(
              'Shipping Address',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildTextField(
                  label: 'Full Name',
                  controller: _nameController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your name' : null,
                ),
                _buildTextField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter phone number'
                      : null,
                  keyboardType: TextInputType.phone,
                  prefix: _buildCountryDropdown(),
                ),
                _buildDropdown(
                  label: 'Province',
                  value: _selectedProvince,
                  items: _provinces[_selectedCountry] ??
                      ['No provinces available'],
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value;
                      _selectedCity = null;
                    });
                  },
                ),
                _buildDropdown(
                  label: 'City',
                  value: _selectedCity,
                  items: (_selectedProvince != null &&
                          _cities[_selectedCountry] != null)
                      ? _cities[_selectedCountry]![_selectedProvince] ??
                          ['No cities available']
                      : ['No cities available'],
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                ),
                _buildTextField(
                  label: 'Street Address',
                  controller: _streetController,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter street address'
                      : null,
                ),
                _buildTextField(
                  label: 'Postal Code',
                  controller: _postalCodeController,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter postal code'
                      : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Save shipping address
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF21D4B4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavBar(currentIndex: 4),
        );
      },
    );
  }
}
