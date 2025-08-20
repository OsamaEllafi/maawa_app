import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Maawa'**
  String get appTitle;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @styleGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Style Guide'**
  String get styleGuideTitle;

  /// No description provided for @typography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get typography;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// No description provided for @inputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get inputs;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;

  /// No description provided for @spacing.
  ///
  /// In en, this message translates to:
  /// **'Spacing'**
  String get spacing;

  /// No description provided for @animations.
  ///
  /// In en, this message translates to:
  /// **'Animations'**
  String get animations;

  /// No description provided for @themeToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get themeToggle;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Language'**
  String get languageToggle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @devTools.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get devTools;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @devToolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get devToolsTitle;

  /// No description provided for @styleGuide.
  ///
  /// In en, this message translates to:
  /// **'Style Guide'**
  String get styleGuide;

  /// No description provided for @roleSimulator.
  ///
  /// In en, this message translates to:
  /// **'Role Simulator'**
  String get roleSimulator;

  /// No description provided for @currentRole.
  ///
  /// In en, this message translates to:
  /// **'Current Role'**
  String get currentRole;

  /// No description provided for @tenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get notFoundTitle;

  /// No description provided for @notFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'404 - Page Not Found'**
  String get notFoundMessage;

  /// No description provided for @notFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The page you\'re looking for doesn\'t exist or has been moved.'**
  String get notFoundSubtitle;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsDontMatch;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameTooShort;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get idNumber;

  /// No description provided for @idNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'ID number is required'**
  String get idNumberRequired;

  /// No description provided for @idNumberTooShort.
  ///
  /// In en, this message translates to:
  /// **'ID number must be at least 5 characters'**
  String get idNumberTooShort;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @ibanRequired.
  ///
  /// In en, this message translates to:
  /// **'IBAN is required'**
  String get ibanRequired;

  /// No description provided for @ibanTooShort.
  ///
  /// In en, this message translates to:
  /// **'IBAN must be at least 10 characters'**
  String get ibanTooShort;

  /// No description provided for @invalidIban.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid IBAN format'**
  String get invalidIban;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @identityVerification.
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get identityVerification;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @submitVerification.
  ///
  /// In en, this message translates to:
  /// **'Submit Verification'**
  String get submitVerification;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get checkYourEmail;

  /// No description provided for @emailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to'**
  String get emailSentMessage;

  /// No description provided for @tryDifferentEmail.
  ///
  /// In en, this message translates to:
  /// **'Try Different Email'**
  String get tryDifferentEmail;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Please sign in to continue.'**
  String get welcomeBack;

  /// No description provided for @createAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started.'**
  String get createAccountMessage;

  /// No description provided for @forgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get forgotPasswordMessage;

  /// No description provided for @kycMessage.
  ///
  /// In en, this message translates to:
  /// **'Please provide accurate information for identity verification.'**
  String get kycMessage;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @invalidIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid ID'**
  String get invalidIdTitle;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @invalidPropertyIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Property with ID \'{id}\' was not found. It may have been removed or the ID is incorrect.'**
  String invalidPropertyIdMessage(Object id);

  /// No description provided for @invalidBookingIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Booking with ID \'{id}\' was not found. It may have been cancelled or the ID is incorrect.'**
  String invalidBookingIdMessage(Object id);

  /// No description provided for @invalidIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Item with ID \'{id}\' was not found. It may have been removed or the ID is incorrect.'**
  String invalidIdMessage(Object id);

  /// No description provided for @displayLarge.
  ///
  /// In en, this message translates to:
  /// **'Display Large'**
  String get displayLarge;

  /// No description provided for @displayMedium.
  ///
  /// In en, this message translates to:
  /// **'Display Medium'**
  String get displayMedium;

  /// No description provided for @displaySmall.
  ///
  /// In en, this message translates to:
  /// **'Display Small'**
  String get displaySmall;

  /// No description provided for @headlineLarge.
  ///
  /// In en, this message translates to:
  /// **'Headline Large'**
  String get headlineLarge;

  /// No description provided for @headlineMedium.
  ///
  /// In en, this message translates to:
  /// **'Headline Medium'**
  String get headlineMedium;

  /// No description provided for @headlineSmall.
  ///
  /// In en, this message translates to:
  /// **'Headline Small'**
  String get headlineSmall;

  /// No description provided for @titleLarge.
  ///
  /// In en, this message translates to:
  /// **'Title Large'**
  String get titleLarge;

  /// No description provided for @titleMedium.
  ///
  /// In en, this message translates to:
  /// **'Title Medium'**
  String get titleMedium;

  /// No description provided for @titleSmall.
  ///
  /// In en, this message translates to:
  /// **'Title Small'**
  String get titleSmall;

  /// No description provided for @bodyLarge.
  ///
  /// In en, this message translates to:
  /// **'Body Large - This is body large text with sufficient line height for readability.'**
  String get bodyLarge;

  /// No description provided for @bodyMedium.
  ///
  /// In en, this message translates to:
  /// **'Body Medium - This is body medium text for general content.'**
  String get bodyMedium;

  /// No description provided for @bodySmall.
  ///
  /// In en, this message translates to:
  /// **'Body Small - This is body small text for secondary information.'**
  String get bodySmall;

  /// No description provided for @labelLarge.
  ///
  /// In en, this message translates to:
  /// **'Label Large'**
  String get labelLarge;

  /// No description provided for @labelMedium.
  ///
  /// In en, this message translates to:
  /// **'Label Medium'**
  String get labelMedium;

  /// No description provided for @labelSmall.
  ///
  /// In en, this message translates to:
  /// **'Label Small'**
  String get labelSmall;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primary;

  /// No description provided for @secondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get secondary;

  /// No description provided for @surface.
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get surface;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @primaryButton.
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  /// No description provided for @secondaryButton.
  ///
  /// In en, this message translates to:
  /// **'Secondary Button'**
  String get secondaryButton;

  /// No description provided for @outlinedButton.
  ///
  /// In en, this message translates to:
  /// **'Outlined Button'**
  String get outlinedButton;

  /// No description provided for @textButton.
  ///
  /// In en, this message translates to:
  /// **'Text Button'**
  String get textButton;

  /// No description provided for @iconButton.
  ///
  /// In en, this message translates to:
  /// **'Icon Button'**
  String get iconButton;

  /// No description provided for @disabledButton.
  ///
  /// In en, this message translates to:
  /// **'Disabled Button'**
  String get disabledButton;

  /// No description provided for @textField.
  ///
  /// In en, this message translates to:
  /// **'Text Field'**
  String get textField;

  /// No description provided for @emailField.
  ///
  /// In en, this message translates to:
  /// **'Email Field'**
  String get emailField;

  /// No description provided for @passwordField.
  ///
  /// In en, this message translates to:
  /// **'Password Field'**
  String get passwordField;

  /// No description provided for @searchField.
  ///
  /// In en, this message translates to:
  /// **'Search Field'**
  String get searchField;

  /// No description provided for @multilineField.
  ///
  /// In en, this message translates to:
  /// **'Multiline Field'**
  String get multilineField;

  /// No description provided for @placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter text here...'**
  String get placeholder;

  /// No description provided for @basicCard.
  ///
  /// In en, this message translates to:
  /// **'Basic Card'**
  String get basicCard;

  /// No description provided for @elevatedCard.
  ///
  /// In en, this message translates to:
  /// **'Elevated Card'**
  String get elevatedCard;

  /// No description provided for @outlinedCard.
  ///
  /// In en, this message translates to:
  /// **'Outlined Card'**
  String get outlinedCard;

  /// No description provided for @cardContent.
  ///
  /// In en, this message translates to:
  /// **'This is card content with some sample text to demonstrate the card layout and typography.'**
  String get cardContent;

  /// No description provided for @xs.
  ///
  /// In en, this message translates to:
  /// **'Extra Small (4px)'**
  String get xs;

  /// No description provided for @sm.
  ///
  /// In en, this message translates to:
  /// **'Small (8px)'**
  String get sm;

  /// No description provided for @md.
  ///
  /// In en, this message translates to:
  /// **'Medium (16px)'**
  String get md;

  /// No description provided for @lg.
  ///
  /// In en, this message translates to:
  /// **'Large (24px)'**
  String get lg;

  /// No description provided for @xl.
  ///
  /// In en, this message translates to:
  /// **'Extra Large (32px)'**
  String get xl;

  /// No description provided for @xxl.
  ///
  /// In en, this message translates to:
  /// **'2X Large (48px)'**
  String get xxl;

  /// No description provided for @fadeIn.
  ///
  /// In en, this message translates to:
  /// **'Fade In'**
  String get fadeIn;

  /// No description provided for @slideIn.
  ///
  /// In en, this message translates to:
  /// **'Slide In'**
  String get slideIn;

  /// No description provided for @scaleIn.
  ///
  /// In en, this message translates to:
  /// **'Scale In'**
  String get scaleIn;

  /// No description provided for @bounce.
  ///
  /// In en, this message translates to:
  /// **'Bounce'**
  String get bounce;

  /// No description provided for @stagger.
  ///
  /// In en, this message translates to:
  /// **'Stagger'**
  String get stagger;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @navBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get navBack;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
