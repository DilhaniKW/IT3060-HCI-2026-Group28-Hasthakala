// All fixed on-screen text in English, Sinhala and Tamil.
// Use  in a widget with:  context.tr('sign_in')
// Adding a new key here with all three languages; missing ones fall back to English.

class AppStrings {
  static const supported = ['en', 'si', 'ta'];

  static const Map<String, Map<String, String>> values = {
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
    'get_started': {'en': 'Get Started', 'si': 'ආරම්භ කරන්න', 'ta': 'தொடங்குங்கள்'},
    'intro_title': {
      'en': 'Discover authentic handmade crafts and empower local artisans.',
      'si': 'සැබෑ අත්කම් නිර්මාණ සොයාගෙන දේශීය ශිල්පීන් සවිබල ගන්වන්න.',
      'ta': 'உண்மையான கைவினைப் பொருட்களைக் கண்டறிந்து உள்ளூர் கைவினைஞர்களுக்கு வலுவூட்டுங்கள்.',
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

    'intro2_title': {
      'en': 'Shop from verified artisans',
      'si': 'සත්‍යාපිත ශිල්පීන්ගෙන් මිලදී ගන්න',
      'ta': 'சரிபார்க்கப்பட்ட கைவினைஞர்களிடம் வாங்குங்கள்',
    },
    'intro2_line': {
      'en': 'See who made it, read reviews and buy with confidence.',
      'si': 'එය සෑදුවේ කවුදැයි බලා, සමාලෝචන කියවා විශ්වාසයෙන් මිලදී ගන්න.',
      'ta': 'யார் செய்தார்கள் என்று பார்த்து, மதிப்புரைகளைப் படித்து நம்பிக்கையுடன் வாங்குங்கள்.',
    },
    'intro3_title': {
      'en': 'Order, chat and track in one place',
      'si': 'ඇණවුම, කතාබහ සහ නිරීක්ෂණය කරන්න එකම තැනක',
      'ta': 'ஆர்டர், உரையாடல், கண்காணிப்பு ஒரே இடத்தில்',
    },
    'intro3_line': {
      'en': 'Clear prices, order updates and messages with the artisan.',
      'si': 'පැහැදිලි මිල, ඇණවුම් යාවත්කාලීන සහ ශිල්පියා සමඟ පණිවිඩ.',
      'ta': 'தெளிவான விலைகள், ஆர்டர் புதுப்பிப்புகள், கைவினைஞருடன் செய்திகள்.',
    },
    'next': {'en': 'Next', 'si': 'ඊළඟ', 'ta': 'அடுத்து'},
    'intro_chip1': {
      'en': 'Handmade in Sri Lanka',
      'si': 'ශ්‍රී ලංකාවේ අතින් තැනූ',
      'ta': 'இலங்கையில் கையால் செய்யப்பட்டது',
    },
    'intro_chip2': {
      'en': 'Verified artisans',
      'si': 'සත්‍යාපිත ශිල්පීන්',
      'ta': 'சரிபார்க்கப்பட்ட கைவினைஞர்கள்',
    },
    'intro_chip3': {
      'en': 'Order updates and chat',
      'si': 'ඇණවුම් යාවත්කාලීන සහ කතාබහ',
      'ta': 'ஆர்டர் புதுப்பிப்புகள் மற்றும் உரையாடல்',
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
    'email': {'en': 'Email Address', 'si': 'විද්‍යුත් තැපැල් ලිපිනය', 'ta': 'மின்னஞ்சல் முகவரி'},
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

    // ---- create account ----
    'create_account_title': {
      'en': 'Create Your Account',
      'si': 'ඔබේ ගිණුම සාදන්න',
      'ta': 'உங்கள் கணக்கை உருவாக்குங்கள்',
    },
    'create_account_sub': {
      'en': 'Join our community of artisans and craft lovers.',
      'si': 'ශිල්පීන් සහ අත්කම් ලෝලීන්ගේ ප්‍රජාවට එක්වන්න.',
      'ta': 'கைவினைஞர்கள் மற்றும் கைவினை ஆர்வலர்களின் சமூகத்தில் சேருங்கள்.',
    },
    'full_name': {'en': 'Full Name', 'si': 'සම්පූර්ණ නම', 'ta': 'முழுப் பெயர்'},
    'full_name_hint': {
      'en': 'Enter your full name',
      'si': 'ඔබේ සම්පූර්ණ නම ඇතුළත් කරන්න',
      'ta': 'உங்கள் முழுப் பெயரை உள்ளிடவும்',
    },
    'email_hint': {
      'en': 'Enter your email',
      'si': 'ඔබේ විද්‍යුත් තැපෑල ඇතුළත් කරන්න',
      'ta': 'உங்கள் மின்னஞ்சலை உள்ளிடவும்',
    },
    'password_hint': {
      'en': 'Enter your password',
      'si': 'ඔබේ මුරපදය ඇතුළත් කරන්න',
      'ta': 'உங்கள் கடவுச்சொல்லை உள்ளிடவும்',
    },
    'confirm_password': {
      'en': 'Confirm Password',
      'si': 'මුරපදය තහවුරු කරන්න',
      'ta': 'கடவுச்சொல்லை உறுதிப்படுத்தவும்',
    },
    'confirm_password_hint': {
      'en': 'Enter your password again',
      'si': 'මුරපදය නැවත ඇතුළත් කරන්න',
      'ta': 'கடவுச்சொல்லை மீண்டும் உள்ளிடவும்',
    },
    'password_rule': {
      'en': 'At least 6 characters',
      'si': 'අවම වශයෙන් අකුරු 6ක්',
      'ta': 'குறைந்தது 6 எழுத்துகள்',
    },
    'passwords_match': {
      'en': 'Passwords match',
      'si': 'මුරපද ගැළපේ',
      'ta': 'கடவுச்சொற்கள் பொருந்துகின்றன',
    },
    'agree_terms': {
      'en': 'I agree to the Terms & Conditions',
      'si': 'නියම සහ කොන්දේසිවලට මම එකඟ වෙමි',
      'ta': 'விதிமுறைகள் மற்றும் நிபந்தனைகளை ஏற்கிறேன்',
    },
    'view': {'en': 'View', 'si': 'බලන්න', 'ta': 'பார்க்க'},
    'close': {'en': 'Close', 'si': 'වසන්න', 'ta': 'மூடு'},
    'terms_title': {
      'en': 'Terms & Conditions',
      'si': 'නියම සහ කොන්දේසි',
      'ta': 'விதிமுறைகள் மற்றும் நிபந்தனைகள்',
    },
    'terms_body': {
      'en': 'HASTHAKALA is a student project (IT3060, Group 28).\n\n'
          '- Use accurate information about yourself and your products.\n'
          '- Only share support access with people you trust.\n'
          '- Test accounts and data may be removed when the project ends.\n'
          '- Your data is stored in Firebase and only used for this app.',
      'si': 'HASTHAKALA ශිෂ්‍ය ව්‍යාපෘතියකි (IT3060, කණ්ඩායම 28).\n\n'
          '- ඔබ සහ ඔබේ නිෂ්පාදන ගැන නිවැරදි තොරතුරු භාවිතා කරන්න.\n'
          '- සහාය ප්‍රවේශය ඔබ විශ්වාස කරන අය සමඟ පමණක් බෙදාගන්න.\n'
          '- ව්‍යාපෘතිය අවසානයේ පරීක්ෂණ ගිණුම් සහ දත්ත ඉවත් කළ හැක.\n'
          '- ඔබේ දත්ත Firebase හි ගබඩා කර මෙම යෙදුම සඳහා පමණක් භාවිතා වේ.',
      'ta': 'HASTHAKALA ஒரு மாணவர் திட்டம் (IT3060, குழு 28).\n\n'
          '- உங்களைப் பற்றியும் உங்கள் தயாரிப்புகள் பற்றியும் சரியான தகவலைப் பயன்படுத்துங்கள்.\n'
          '- நீங்கள் நம்பும் நபர்களுடன் மட்டுமே உதவி அணுகலைப் பகிருங்கள்.\n'
          '- திட்டம் முடிந்ததும் சோதனைக் கணக்குகளும் தரவும் நீக்கப்படலாம்.\n'
          '- உங்கள் தரவு Firebase-இல் சேமிக்கப்பட்டு இந்த செயலிக்கு மட்டுமே பயன்படுத்தப்படும்.',
    },
    'have_account': {
      'en': 'Already have an account?',
      'si': 'දැනටමත් ගිණුමක් තිබේද?',
      'ta': 'ஏற்கனவே கணக்கு உள்ளதா?',
    },

    // ---- messages (validation and sign-in errors) ----
    'err_email_required': {
      'en': 'Email address is required',
      'si': 'විද්‍යුත් තැපැල් ලිපිනය අවශ්‍යයි',
      'ta': 'மின்னஞ்சல் முகவரி தேவை',
    },
    'err_email_invalid': {
      'en': 'Enter a valid email address',
      'si': 'වලංගු විද්‍යුත් තැපැල් ලිපිනයක් ඇතුළත් කරන්න',
      'ta': 'சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்',
    },
    'err_password_required': {
      'en': 'Password is required',
      'si': 'මුරපදය අවශ්‍යයි',
      'ta': 'கடவுச்சொல் தேவை',
    },
    'err_password_short': {
      'en': 'Password must be at least 6 characters',
      'si': 'මුරපදයේ අවම වශයෙන් අකුරු 6ක් තිබිය යුතුය',
      'ta': 'கடவுச்சொல் குறைந்தது 6 எழுத்துகள் இருக்க வேண்டும்',
    },
    'err_name_required': {
      'en': 'Please enter your full name',
      'si': 'කරුණාකර ඔබේ සම්පූර්ණ නම ඇතුළත් කරන්න',
      'ta': 'உங்கள் முழுப் பெயரை உள்ளிடவும்',
    },
    'err_password_mismatch': {
      'en': 'Passwords do not match',
      'si': 'මුරපද නොගැළපේ',
      'ta': 'கடவுச்சொற்கள் பொருந்தவில்லை',
    },
    'err_terms': {
      'en': 'Please agree to the Terms & Conditions to continue.',
      'si': 'ඉදිරියට යාමට නියම සහ කොන්දේසිවලට එකඟ වන්න.',
      'ta': 'தொடர விதிமுறைகள் மற்றும் நிபந்தனைகளை ஏற்கவும்.',
    },
    'err_wrong_login': {
      'en': 'Email or password is incorrect. Please try again.',
      'si': 'විද්‍යුත් තැපෑල හෝ මුරපදය වැරදියි. නැවත උත්සාහ කරන්න.',
      'ta': 'மின்னஞ்சல் அல்லது கடவுச்சொல் தவறானது. மீண்டும் முயற்சிக்கவும்.',
    },
    'err_email_in_use': {
      'en': 'An account already exists with this email. Try signing in instead.',
      'si': 'මෙම විද්‍යුත් තැපෑලෙන් දැනටමත් ගිණුමක් ඇත. ඒ වෙනුවට පුරනය වන්න.',
      'ta': 'இந்த மின்னஞ்சலுடன் ஏற்கனவே ஒரு கணக்கு உள்ளது. உள்நுழைய முயற்சிக்கவும்.',
    },
    'err_offline': {
      'en': 'No internet connection. Check your connection and try again.',
      'si': 'අන්තර්ජාල සම්බන්ධතාවක් නැත. සම්බන්ධතාව පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'ta': 'இணைய இணைப்பு இல்லை. இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.',
    },
    'err_too_many': {
      'en': 'Too many attempts. Please wait a moment and try again.',
      'si': 'උත්සාහයන් ඉක්මවා යයි. මොහොතක් රැඳී නැවත උත්සාහ කරන්න.',
      'ta': 'அதிக முயற்சிகள். சிறிது நேரம் காத்திருந்து மீண்டும் முயற்சிக்கவும்.',
    },
    'err_disabled': {
      'en': 'This account has been disabled. Please contact support.',
      'si': 'මෙම ගිණුම අක්‍රිය කර ඇත. සහාය අමතන්න.',
      'ta': 'இந்தக் கணக்கு முடக்கப்பட்டுள்ளது. உதவியைத் தொடர்பு கொள்ளவும்.',
    },
    'err_generic': {
      'en': 'Something went wrong. Please try again.',
      'si': 'යම් දෝෂයක් සිදුවිය. නැවත උත්සාහ කරන්න.',
      'ta': 'ஏதோ தவறு நடந்தது. மீண்டும் முயற்சிக்கவும்.',
    },
    'err_create_account': {
      'en': 'We could not create your account. Please try again.',
      'si': 'ඔබේ ගිණුම සෑදීමට නොහැකි විය. නැවත උත්සාහ කරන්න.',
      'ta': 'உங்கள் கணக்கை உருவாக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.',
    },
    'err_load_account': {
      'en': 'We could not load your account. Check your connection and try again.',
      'si': 'ඔබේ ගිණුම පූරණය කළ නොහැකි විය. සම්බන්ධතාව පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'ta': 'உங்கள் கணக்கை ஏற்ற முடியவில்லை. இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.',
    },

    // ---- account setup, reset password, contexts ----
    'account_created_title': {
      'en': 'Account Created!',
      'si': 'ගිණුම සාදන ලදී!',
      'ta': 'கணக்கு உருவாக்கப்பட்டது!',
    },
    'account_created_sub': {
      'en': 'Welcome to HASTHAKALA. Let\'s get started on your journey.',
      'si': 'HASTHAKALA වෙත සාදරයෙන් පිළිගනිමු. ඔබේ ගමන ආරම්භ කරමු.',
      'ta': 'HASTHAKALA-வுக்கு வரவேற்கிறோம். உங்கள் பயணத்தைத் தொடங்குவோம்.',
    },
    'purpose_title': {
      'en': 'How will you start using HASTHAKALA?',
      'si': 'ඔබ HASTHAKALA භාවිතා කිරීම ආරම්භ කරන්නේ කෙසේද?',
      'ta': 'HASTHAKALA-வை எப்படிப் பயன்படுத்தத் தொடங்குவீர்கள்?',
    },
    'purpose_sub': {
      'en': 'Choose how you want to begin. Sellers can still shop too.',
      'si': 'ආරම්භ කිරීමට අවශ්‍ය ආකාරය තෝරන්න. විකුණන අයටත් මිලදී ගත හැක.',
      'ta': 'எப்படித் தொடங்க வேண்டும் என்பதைத் தேர்ந்தெடுங்கள். விற்பவர்களும் வாங்கலாம்.',
    },
    'purpose_shop': {
      'en': 'Shop for Crafts',
      'si': 'අත්කම් මිලදී ගන්න',
      'ta': 'கைவினைப் பொருட்களை வாங்குங்கள்',
    },
    'purpose_shop_sub': {
      'en': 'Discover and support local artisans',
      'si': 'දේශීය ශිල්පීන් සොයාගෙන ඔවුන්ට සහාය වන්න',
      'ta': 'உள்ளூர் கைவினைஞர்களைக் கண்டறிந்து ஆதரியுங்கள்',
    },
    'purpose_sell': {
      'en': 'Sell My Crafts',
      'si': 'මගේ අත්කම් විකුණන්න',
      'ta': 'என் கைவினைப் பொருட்களை விற்கவும்',
    },
    'purpose_sell_sub': {
      'en': 'Create and manage your artisan presence',
      'si': 'ඔබේ ශිල්පී පැතිකඩ සාදා කළමනාකරණය කරන්න',
      'ta': 'உங்கள் கைவினைஞர் இருப்பை உருவாக்கி நிர்வகிக்கவும்',
    },
    'sign_out': {
      'en': 'Sign out',
      'si': 'ඉවත් වන්න',
      'ta': 'வெளியேறு',
    },
    'all_set_title': {
      'en': 'You\'re all set!',
      'si': 'සියල්ල සූදානම්!',
      'ta': 'எல்லாம் தயார்!',
    },
    'all_set_sub': {
      'en': 'Start exploring handmade crafts from across Sri Lanka.',
      'si': 'ශ්‍රී ලංකාව පුරා අත්කම් නිර්මාණ ගවේෂණය කිරීම අරඹන්න.',
      'ta': 'இலங்கை முழுவதிலுமிருந்து கைவினைப் பொருட்களை ஆராயத் தொடங்குங்கள்.',
    },
    'continue_home': {
      'en': 'Continue to Home',
      'si': 'මුල් පිටුවට යන්න',
      'ta': 'முகப்புக்குச் செல்லவும்',
    },
    'artisan_started_title': {
      'en': 'Your artisan setup has started!',
      'si': 'ඔබේ ශිල්පී සැකසුම ආරම්භ විය!',
      'ta': 'உங்கள் கைவினைஞர் அமைப்பு தொடங்கியது!',
    },
    'artisan_started_sub': {
      'en': 'Next, let\'s complete your profile to showcase your crafts.',
      'si': 'ඊළඟට, ඔබේ නිර්මාණ පෙන්වීමට පැතිකඩ සම්පූර්ණ කරමු.',
      'ta': 'அடுத்து, உங்கள் கைவினைகளைக் காட்ட சுயவிவரத்தை நிறைவு செய்வோம்.',
    },
    'continue_profile': {
      'en': 'Continue to Profile',
      'si': 'පැතිකඩට යන්න',
      'ta': 'சுயவிவரத்துக்குச் செல்லவும்',
    },
    'reset_title': {
      'en': 'Reset Your Password',
      'si': 'ඔබේ මුරපදය යළි සකසන්න',
      'ta': 'உங்கள் கடவுச்சொல்லை மீட்டமைக்கவும்',
    },
    'reset_sub': {
      'en': 'We\'ll send you a link to reset your password.',
      'si': 'මුරපදය යළි සැකසීමට අපි ඔබට සබැඳියක් එවන්නෙමු.',
      'ta': 'கடவுச்சொல்லை மீட்டமைக்க ஒரு இணைப்பை அனுப்புவோம்.',
    },
    'send_reset_link': {
      'en': 'Send Reset Link',
      'si': 'යළි සැකසීමේ සබැඳිය යවන්න',
      'ta': 'மீட்டமைப்பு இணைப்பை அனுப்பு',
    },
    'back_to_sign_in': {
      'en': 'Back to Sign In',
      'si': 'පුරනය වීමට ආපසු',
      'ta': 'உள்நுழைவுக்குத் திரும்பு',
    },
    'check_email_title': {
      'en': 'Check your email',
      'si': 'ඔබේ විද්‍යුත් තැපෑල පරීක්ෂා කරන්න',
      'ta': 'உங்கள் மின்னஞ்சலைச் சரிபார்க்கவும்',
    },
    'check_email_sub': {
      'en': 'If an account exists for {email}, we sent password recovery instructions to it.',
      'si': '{email} සඳහා ගිණුමක් තිබේ නම්, මුරපදය ප්‍රතිසාධනය කිරීමේ උපදෙස් එයට යවා ඇත.',
      'ta': '{email} க்கு கணக்கு இருந்தால், கடவுச்சொல் மீட்பு வழிமுறைகளை அனுப்பியுள்ளோம்.',
    },
    'resend': {
      'en': 'Resend',
      'si': 'නැවත යවන්න',
      'ta': 'மீண்டும் அனுப்பு',
    },
    'continue_as': {
      'en': 'Continue as {name}',
      'si': '{name} ලෙස ඉදිරියට',
      'ta': '{name} ஆக தொடரவும்',
    },
    'continue_as_sub': {
      'en': 'You have more than one way to use HASTHAKALA. Choose how you\'d like to continue.',
      'si': 'ඔබට HASTHAKALA භාවිතා කිරීමට ක්‍රම කිහිපයක් ඇත. ඉදිරියට යන ආකාරය තෝරන්න.',
      'ta': 'HASTHAKALA-வைப் பயன்படுத்த உங்களுக்குப் பல வழிகள் உள்ளன. எப்படித் தொடர வேண்டும் என்பதைத் தேர்ந்தெடுங்கள்.',
    },
    'ctx_buyer': {
      'en': 'Buyer',
      'si': 'ගැනුම්කරු',
      'ta': 'வாங்குபவர்',
    },
    'ctx_buyer_sub': {
      'en': 'Shop for unique handmade crafts from local artisans',
      'si': 'දේශීය ශිල්පීන්ගෙන් අද්විතීය අත්කම් මිලදී ගන්න',
      'ta': 'உள்ளூர் கைவினைஞர்களிடமிருந்து தனித்துவமான கைவினைப் பொருட்களை வாங்குங்கள்',
    },
    'ctx_artisan': {
      'en': 'Artisan',
      'si': 'ශිල්පියා',
      'ta': 'கைவினைஞர்',
    },
    'ctx_artisan_sub': {
      'en': 'Manage your crafts, orders and business',
      'si': 'ඔබේ නිර්මාණ, ඇණවුම් සහ ව්‍යාපාරය කළමනාකරණය කරන්න',
      'ta': 'உங்கள் கைவினைகள், ஆர்டர்கள் மற்றும் வணிகத்தை நிர்வகிக்கவும்',
    },
    'ctx_supporting': {
      'en': 'Supporting {name}',
      'si': '{name} ට සහාය වෙමින්',
      'ta': '{name} க்கு உதவுகிறீர்கள்',
    },
    'ctx_supporting_sub': {
      'en': 'Help with the activities you were allowed',
      'si': 'ඔබට අවසර දුන් කටයුතුවලට උදව් කරන්න',
      'ta': 'உங்களுக்கு அனுமதிக்கப்பட்ட செயல்களில் உதவுங்கள்',
    },
    'check_verified': {
      'en': 'Account verified',
      'si': 'ගිණුම තහවුරු විය',
      'ta': 'கணக்கு சரிபார்க்கப்பட்டது',
    },
    'check_profiles': {
      'en': 'Checking your profiles...',
      'si': 'ඔබේ පැතිකඩ පරීක්ෂා කරමින්...',
      'ta': 'உங்கள் சுயவிவரங்களைச் சரிபார்க்கிறது...',
    },
    'check_workspace': {
      'en': 'Loading your workspace...',
      'si': 'ඔබේ වැඩ අවකාශය පූරණය කරමින්...',
      'ta': 'உங்கள் பணியிடத்தை ஏற்றுகிறது...',
    },
    'sign_out_title': {
      'en': 'Sign out?',
      'si': 'ඉවත් වන්නද?',
      'ta': 'வெளியேறவா?',
    },
    'sign_out_body': {
      'en': 'You will need to sign in again to access your account.',
      'si': 'ඔබේ ගිණුමට පිවිසීමට නැවත පුරනය වීමට සිදුවේ.',
      'ta': 'உங்கள் கணக்கை அணுக மீண்டும் உள்நுழைய வேண்டும்.',
    },
    'cancel': {
      'en': 'Cancel',
      'si': 'අවලංගු කරන්න',
      'ta': 'ரத்துசெய்',
    },
    'support_removed_title': {
      'en': 'Support access is no longer available',
      'si': 'සහාය ප්‍රවේශය තවදුරටත් නොමැත',
      'ta': 'உதவி அணுகல் இனி கிடைக்காது',
    },
    'support_removed_sub': {
      'en': 'Your access to {name}\'s business has changed or been removed.',
      'si': '{name} ගේ ව්‍යාපාරයට ඔබේ ප්‍රවේශය වෙනස් කර හෝ ඉවත් කර ඇත.',
      'ta': '{name} இன் வணிகத்துக்கான உங்கள் அணுகல் மாற்றப்பட்டது அல்லது நீக்கப்பட்டது.',
    },
    'err_save_choice': {
      'en': 'We could not save your choice. Check your connection and try again.',
      'si': 'ඔබේ තේරීම සුරැකීමට නොහැකි විය. සම්බන්ධතාව පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'ta': 'உங்கள் தேர்வைச் சேமிக்க முடியவில்லை. இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.',
    },
    'err_reset_failed': {
      'en': 'We could not send the reset link. Please try again.',
      'si': 'යළි සැකසීමේ සබැඳිය යැවිය නොහැකි විය. නැවත උත්සාහ කරන්න.',
      'ta': 'மீட்டமைப்பு இணைப்பை அனுப்ப முடியவில்லை. மீண்டும் முயற்சிக்கவும்.',
    },

    // ---- bottom navigation ----
    'nav_home': {'en': 'Home', 'si': 'මුල් පිටුව', 'ta': 'முகப்பு'},
    'nav_search': {'en': 'Search', 'si': 'සොයන්න', 'ta': 'தேடல்'},
    'nav_orders': {'en': 'Orders', 'si': 'ඇණවුම්', 'ta': 'ஆர்டர்கள்'},
    'nav_products': {'en': 'Products', 'si': 'නිෂ්පාදන', 'ta': 'தயாரிப்புகள்'},
    'nav_profile': {'en': 'Profile', 'si': 'පැතිකඩ', 'ta': 'சுயவிவரம்'},
  };

  // English messages from validators / Firebase -> key, so they can be shown
  // in the chosen language without changing where they come from
  static const Map<String, String> messageKeys = {
    'We could not save your choice. Check your connection and try again.': 'err_save_choice',
    'We could not send the reset link. Please try again.': 'err_reset_failed',
    'Please enter your full name': 'err_name_required',
    'Passwords do not match': 'err_password_mismatch',
    'Email address is required': 'err_email_required',
    'Enter a valid email address': 'err_email_invalid',
    'Please enter a valid email address.': 'err_email_invalid',
    'Password is required': 'err_password_required',
    'Password must be at least 6 characters': 'err_password_short',
    'Password must be at least 6 characters.': 'err_password_short',
    'Email or password is incorrect. Please try again.': 'err_wrong_login',
    'An account already exists with this email. Try signing in instead.': 'err_email_in_use',
    'No internet connection. Check your connection and try again.': 'err_offline',
    'Too many attempts. Please wait a moment and try again.': 'err_too_many',
    'This account has been disabled. Please contact support.': 'err_disabled',
    'Something went wrong. Please try again.': 'err_generic',
    'We could not create your account. Please try again.': 'err_create_account',
    'We could not load your account. Check your connection and try again.': 'err_load_account',
  };

  static String get(String key, String lang) {
    final entry = values[key];
    if (entry == null) return key; // shows the key so missing text is easy to spot
    return entry[lang] ?? entry['en'] ?? key;
  }
}
