import 'discovery_strings.dart';

// All fixed on-screen text in English, Sinhala and Tamil.
// Use  in a widget with:  context.tr('sign_in')
// Adding a new key here with all three languages; missing ones fall back to English.

class AppStrings {
  static const supported = ['en', 'si', 'ta'];

  static const Map<String, Map<String, String>> values = {
    ...discoveryStrings,
    // ---- general ----
    'continue': {'en': 'Continue', 'si': 'ඉදිරියට', 'ta': 'தொடரவும்'},
    'skip': {'en': 'Skip', 'si': 'මඟ හරින්න', 'ta': 'தவிர்'},
    'app_tagline': {
      'en': 'Handmade. Heritage. Heart.',
      'si': 'අතින් තැනූ. උරුමය. හදවත.',
      'ta': 'கைவினை. பாரம்பரியம். இதயம்.',
    },

    // ---- language ----
    'choose_language': {
      'en': 'Choose Language',
      'si': 'භාෂාව තෝරන්න',
      'ta': 'மொழியைத் தேர்ந்தெடுக்கவும்',
    },
    'choose_language_sub': {
      'en': 'Select your preferred language to continue.',
      'si': 'ඉදිරියට යාමට ඔබ කැමති භාෂාව තෝරන්න.',
      'ta': 'தொடர உங்களுக்கு விருப்பமான மொழியைத் தேர்ந்தெடுக்கவும்.',
    },
    'language_change_later': {
      'en': 'You can change this later in Profile.',
      'si': 'පසුව පැතිකඩ තුළින් මෙය වෙනස් කළ හැක.',
      'ta': 'இதை பின்னர் சுயவிவரத்தில் மாற்றலாம்.',
    },
    'language': {'en': 'Language', 'si': 'භාෂාව', 'ta': 'மொழி'},
    'language_sub': {
      'en': 'Change the app language',
      'si': 'යෙදුමේ භාෂාව වෙනස් කරන්න',
      'ta': 'செயலியின் மொழியை மாற்றவும்',
    },
    'language_saved': {
      'en': 'Language updated',
      'si': 'භාෂාව යාවත්කාලීන කළා',
      'ta': 'மொழி புதுப்பிக்கப்பட்டது',
    },

    // ---- intro ----
    'get_started': {
      'en': 'Get Started',
      'si': 'ආරම්භ කරන්න',
      'ta': 'தொடங்குங்கள்'
    },
    'intro_title': {
      'en': 'Discover authentic handmade crafts and empower local artisans.',
      'si': 'සැබෑ අත්කම් නිර්මාණ සොයාගෙන දේශීය ශිල්පීන් සවිබල ගන්වන්න.',
      'ta':
          'உண்மையான கைவினைப் பொருட்களைக் கண்டறிந்து உள்ளூர் கைவினைஞர்களுக்கு வலுவூட்டுங்கள்.',
    },
    'intro_line1': {
      'en': 'Unique stories. Real people.',
      'si': 'අද්විතීය කතා. සැබෑ මිනිසුන්.',
      'ta': 'தனித்துவமான கதைகள். உண்மையான மனிதர்கள்.',
    },
    'intro_line2': {
      'en': 'Empowering local artisans across Sri Lanka.',
      'si': 'ශ්‍රී ලංකාව පුරා දේශීය ශිල්පීන් සවිබල ගැන්වීම.',
      'ta': 'இலங்கை முழுவதும் உள்ளூர் கைவினைஞர்களுக்கு வலுவூட்டல்.',
    },

    // ---- sign in ----
    'welcome_back': {
      'en': 'Welcome Back',
      'si': 'නැවත සාදරයෙන් පිළිගනිමු',
      'ta': 'மீண்டும் வருக',
    },
    'sign_in_sub': {
      'en': 'Sign in to continue your journey',
      'si': 'ඔබේ ගමන දිගටම කරගෙන යාමට පුරනය වන්න',
      'ta': 'உங்கள் பயணத்தைத் தொடர உள்நுழையவும்',
    },
    'email': {
      'en': 'Email Address',
      'si': 'විද්‍යුත් තැපැල් ලිපිනය',
      'ta': 'மின்னஞ்சல் முகவரி'
    },
    'password': {'en': 'Password', 'si': 'මුරපදය', 'ta': 'கடவுச்சொல்'},
    'show_password': {
      'en': 'Show password',
      'si': 'මුරපදය පෙන්වන්න',
      'ta': 'கடவுச்சொல்லைக் காட்டு',
    },
    'hide_password': {
      'en': 'Hide password',
      'si': 'මුරපදය සඟවන්න',
      'ta': 'கடவுச்சொல்லை மறை',
    },
    'forgot_password': {
      'en': 'Forgot password?',
      'si': 'මුරපදය අමතකද?',
      'ta': 'கடவுச்சொல் மறந்துவிட்டதா?',
    },
    'sign_in': {'en': 'Sign In', 'si': 'පුරනය වන්න', 'ta': 'உள்நுழைக'},
    'new_here': {
      'en': 'New to HASTHAKALA?',
      'si': 'HASTHAKALA වෙත අලුත්ද?',
      'ta': 'HASTHAKALA-வுக்கு புதியவரா?',
    },
    'create_account': {
      'en': 'Create Account',
      'si': 'ගිණුමක් සාදන්න',
      'ta': 'கணக்கை உருவாக்கவும்',
    },
    'signing_in': {
      'en': 'Signing you in...',
      'si': 'ඔබව පුරනය කරමින්...',
      'ta': 'உள்நுழைகிறது...',
    },
    'signing_in_sub': {
      'en': 'Please wait while we verify your account.',
      'si': 'අපි ඔබේ ගිණුම තහවුරු කරන තුරු රැඳී සිටින්න.',
      'ta': 'உங்கள் கணக்கைச் சரிபார்க்கும் வரை காத்திருக்கவும்.',
    },
    'checking_access': {
      'en': 'Checking your available access...',
      'si': 'ඔබට ඇති ප්‍රවේශය පරීක්ෂා කරමින්...',
      'ta': 'உங்களுக்கான அணுகலைச் சரிபார்க்கிறது...',
    },
    'checking_access_sub': {
      'en': 'Verifying your account and loading your workspace.',
      'si': 'ඔබේ ගිණුම තහවුරු කර වැඩ අවකාශය පූරණය කරමින්.',
      'ta': 'உங்கள் கணக்கைச் சரிபார்த்து பணியிடத்தை ஏற்றுகிறது.',
    },

    // ---- bottom navigation ----
    'nav_home': {'en': 'Home', 'si': 'මුල් පිටුව', 'ta': 'முகப்பு'},
    'nav_search': {'en': 'Search', 'si': 'සොයන්න', 'ta': 'தேடல்'},
    'nav_orders': {'en': 'Orders', 'si': 'ඇණවුම්', 'ta': 'ஆர்டர்கள்'},
    'nav_products': {'en': 'Products', 'si': 'නිෂ්පාදන', 'ta': 'தயாரிப்புகள்'},
    'nav_profile': {'en': 'Profile', 'si': 'පැතිකඩ', 'ta': 'சுயவிவரம்'},
  };

  static String get(String key, String lang) {
    final entry = values[key];
    if (entry == null)
      return key; // shows the key so missing text is easy to spot
    return entry[lang] ?? entry['en'] ?? key;
  }
}
